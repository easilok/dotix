# TODO: move this configuration to home-manager
{ config, pkgs, ... }: {

  programs.mise = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

}

