{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    emacs
    texinfo
    cmake
    libtool
    ispell
    emacsPackages.mu4e
  ];
}

