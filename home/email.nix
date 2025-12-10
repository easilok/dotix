{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    isync
    # mbsync
    mu
    msmtp
  ];
}
