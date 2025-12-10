{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    emacs
    makeinfo
    cmake
    libtool
    ispell
    emacsPackages.mu4e
  ];
}

