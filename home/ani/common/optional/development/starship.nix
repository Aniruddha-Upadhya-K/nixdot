{ config, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    configPath = "${config.hostSpec.home}/.config/starship/starship.toml";

    settings = {
      # Get editor completions based on the config schema
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = true;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      format = ''$username$hostname$all'';
    };
  };
}
