{ pkgs, ... }:

pkgs.writers.writePython3Bin "hltags" {} /* python */ ''
  import sys
  import subprocess


  HELP = """
  hltags - inspect tag usage in hledger

  USAGE:
    hltags [account|all] [options]

  MODES:
    hltags
        Show this help message

    hltags <account> [account2 ...]
        Show tags used in this accounts and its subaccounts

    hltags all
        Show tags for all accounts (root)

    hltags (no account, but no args)
        Show help (useful reminder)

  OPTIONS:
    -f, --file <file>
        Use a specific hledger file

    -a, --all-accounts
        Include accounts with no tags

    -h, --help
        Show this help message

  EXAMPLES:
    hltags expenses
    hltags expenses assets
    hltags expenses:food
    hltags all
    hltags expenses -a
    hltags -f journal.hledger expenses
  """


  def run_hledger(file):
      cmd = ["hledger"]
      if file:
          cmd += ["-f", file]
      cmd += ["print"]

      result = subprocess.run(cmd, capture_output=True, text=True)
      if result.returncode != 0:
          print(result.stderr, file=sys.stderr)
          sys.exit(1)

      return result.stdout.splitlines()


  def extract_tags(comment):
      tags = set()
      parts = comment.split(",")
      for p in parts:
          p = p.strip()
          if ":" in p:
              key = p.split(":", 1)[0].strip()
              if key:
                  tags.add(key)
      return tags


  def parse_ledger(lines):
      accounts = {}
      all_tags = set()

      for line in lines:
          # skip txn lines
          if not line.startswith(" "):
              continue

          stripped = line.lstrip()

          # extract account (before double space)
          if "  " in stripped:
              acct = stripped.split("  ", 1)[0]
          else:
              acct = stripped.strip()

          if acct not in accounts:
              accounts[acct] = set()

          # extract tags
          if ";" in line:
              comment = line.split(";", 1)[1]
              tags = extract_tags(comment)

              for t in tags:
                  accounts[acct].add(t)
                  all_tags.add(t)

      return accounts, all_tags


  def filter_accounts(accounts, targets):
      if not targets:
          return accounts

      result = {}
      for acct in accounts:
          for t in targets:
              if acct.startswith(t):
                  result[acct] = accounts[acct]
                  break
      return result


  def print_accounts(accounts, include_empty=False):
      for acct in sorted(accounts):
          tags = sorted(accounts[acct])

          if not tags and not include_empty:
              continue

          print(acct)
          if tags:
              print("    " + ", ".join(tags))
          else:
              print("    (no tags)")
          print()


  def main():
      file = None
      mode = "help"
      accounts = []
      include_empty = False

      args = sys.argv[1:]
      i = 0

      while i < len(args):
          arg = args[i]

          if arg in ("-h", "--help"):
              print(HELP.strip())
              return

          elif arg in ("-f", "--file"):
              if i + 1 >= len(args):
                  print("error: missing file path", file=sys.stderr)
                  sys.exit(1)
              file = args[i + 1]
              i += 2

          elif arg in ("-a", "--all-accounts"):
              include_empty = True
              i += 1

          elif arg == "all":
              mode = "account"
              accounts = []
              i += 1

          else:
              if mode == "help":
                  mode = "account"
              accounts.append(arg)
              i += 1

      if mode == "help":
          print(HELP.strip())
          return

      lines = run_hledger(file)
      parsed_accounts, all_tags = parse_ledger(lines)

      filtered = filter_accounts(parsed_accounts, accounts)
      print_accounts(filtered, include_empty)


  if __name__ == "__main__":
      main()
''
