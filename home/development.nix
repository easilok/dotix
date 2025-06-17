# TODO: move this configuration to home-manager
{ config, pkgs, ... }: {
  home.packages = with pkgs; [ mise ];

  imports = [ ./neovim.nix ];

}

