{ config, lib, pkgs, ... }: {
  programs.eza = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    settings = {
      aws = { disabled = true; };
      character = { vimcmd_symbol = "[❮](bold yellow)"; };
      custom.production_env = {
        command = " ~/.local/bin/detect_production_env.sh ";
        when = "[ -f ~/.local/bin/detect_production_env.sh ]";
        style = "bold red";
        format = "[\${output} ]($style)";
        description =
          "Show danger indication when a production environment variable is found.";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

}

