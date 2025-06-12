{ config, pkgs, ... }: {
  # home.packages = with pkgs; [
  #   rofi
  # ];

  programs.rofi = {
    enable = true;
    modes = [ "drun" "run" "ssh" "window" "combi" ];
    pass = { enable = true; };
    extraConfig = {
      show-icons = true;
      combi-modi = "window,drun,ssh,run";
      display-window = "Window";
      display-drun = "Apps";
    };
    theme = "~/.config/rofi/theme.rasi";
  };

  # TODO: migrate to config here
  home.file.rofi-theme = {
    source = ../dotfiles/rofi/.config/rofi/theme.rasi;
    target = ".config/rofi/theme.rasi";
  };
}

