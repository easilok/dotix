{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    w3m
    weechat
    babashka
    gum
  ];
}


