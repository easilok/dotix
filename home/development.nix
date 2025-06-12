# TODO: move this configuration to home-manager
{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    starship
    zoxide
    zsh
    mise
  ];

  imports = [ ./neovim.nix ];
}

