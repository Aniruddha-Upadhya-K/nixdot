{ pkgs, ... }:

pkgs.writeShellScriptBin "screenshot" ''
  if [[ $# -ne 1 ]]; then
    echo "There should be exactly 1 argument"
    exit 1
  fi

  if ! echo "output region" | grep -wq $1; then
    echo -e "Arguments should be one of the following\noutput\nregion"
    exit 1
  fi

  LOCKFILE=/tmp/hyprshot.lock

  # Function to check if the lock file is held by an active process
  is_lock_held() {
    if [[ -f "$LOCKFILE" ]]; then
      read -r LOCK_PID < "$LOCKFILE"
      if ps -p "$LOCK_PID" > /dev/null 2>&1; then
        return 0  # Lock is held by an active process
      else
        rm -f "$LOCKFILE"  # Stale lock, clean it up
      fi
    fi
    return 1  # No active lock
  }

  # Create lock if not already held
  if is_lock_held; then
    echo "hyprshot is already running."
    exit 1
  else
    echo "$$" > "$LOCKFILE"  # Write current PID to lock file
  fi

  # Cleanup lock file on exit
  trap 'rm "$LOCKFILE"' EXIT

  # Run hyprshot and satty command
  ${pkgs.hyprshot}/bin/hyprshot -zm $1 --raw | ${pkgs.satty}/bin/satty --filename - -o ~/Pictures/Screenshots/%Y-%m-%d_%H:%M:%S.png
''
