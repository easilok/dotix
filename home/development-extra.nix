# TODO: move this configuration to home-manager
{ config, pkgs, ... }: {

  imports = [ ./emacs.nix ];

  home.packages = with pkgs; [
    ghostty
  ];
}

