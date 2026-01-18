{ config, pkgs, ... }: {
  imports = [ ./email.nix ];

  home.packages = with pkgs; [
    w3m
    weechat
    babashka
    gum
    parallel
    profanity
    restic
    rclone
    nextcloud-client
    ffmpeg
  ];
}
