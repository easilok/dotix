# TODO: move this configuration to home-manager
{ config, pkgs, ... }: {
  home.packages = with pkgs; [ mise ];

  programs.mise = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

  imports = [ ./neovim.nix ];

}

