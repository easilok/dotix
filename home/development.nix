# TODO: move this configuration to home-manager
{ config, pkgs, ... }: {
  home.packages = with pkgs; [ taskwarrior3 timewarrior kanata ];

  programs.mise = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

  imports = [ ./neovim.nix ];

}

