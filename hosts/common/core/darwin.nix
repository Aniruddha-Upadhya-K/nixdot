{ pkgs, lib, ... }:

{
  # Database for aiding terminal-based programs
  environment = {
    enableAllTerminfo = true;
    systemPackages = with pkgs; [ nh ];
  };

  # This should be handled by config.security.pam.sshAgentAuth.enable
  security.sudo.extraConfig = ''
    Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
    Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
    Defaults timestamp_timeout=120 # only ask for password every 2h
    # Keep SSH_AUTH_SOCK so that pam_ssh_agent_auth.so can do its magic.
    Defaults env_keep+=SSH_AUTH_SOCK
  '';

  # Enable TouchID for PAM auth: you could also place security/pam or other service configs here:
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true; # fixes Touch ID for sudo not working inside tmux
  };

  #
  # ========== Garbage Collection ==========
  #
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      # Run gc every Monday at 3am or when next time pc wakes
      interval = {
        Weekday = 1;
        Hour = 3;
        Minute = 0;
      };
    };
  };

  #
  # ========== Localization ==========
  #
  # Set your time zone.
  time.timeZone = lib.mkDefault "Asia/Kolkata";
}
