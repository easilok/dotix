{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    iosevka
    roboto
    cantarell-fonts
    noto-fonts
    noto-fonts-color-emoji
    font-awesome
    dejavu_fonts
    source-code-pro
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.iosevka-term
  ];

  fonts.fontconfig.enable = true;

}

