{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    arandr
    nm-tray
    picom
  ];

  xsession.windowManager = {
    i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod4";
        gaps = {
          inner = 10;
          outer = 5;
        };
      };
    };
    awesome = {
      enable = true;
    };
  };

  # home.file.".config/awesome" = {
  #   source = ./dotfiles/awesome/.config/awesome;
  #   recursive = true;
  # };

  home.file = {
    ".local/bin/awesomewm-autorun.sh" = {
      source = ./bin/awesomewm-autorun.sh;
      executable = true;
    };
    ".local/bin/i3lock-clock-image" = {
      source = ./bin/i3lock-clock-image;
      executable = true;
    };
    ".local/bin/i3lock-clock" = {
      source = ./bin/i3lock-clock;
      executable = true;
    };
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      # "super + F1"            = pkgs.writeShellScript "script" "echo $USER";
      # TODO: use default terminal as setting
      "super + Return" = "wezterm";
      "super + d" = "rofi -show drun";
      "super + p" = "rofi -show drun";
      "shift + super + d" = "rofi -show run";
      "shift + super + p" = "rofi -show run";
      "shift + super + Escape" = "dmenu-power";
      "shift + super + h" = "dmenu-power";
      "shift + super + w" = "rofi -show window";
      "super + b" = "dmenu-bookmarks";
      "super + e" = "pcmanfm";
      "control + alt + h" = "show-clipboard";
      "Print" = "flameshot gui";

      "shift + Print" = "flameshot launcher";

      # make sxhkd reload its configuration files:
      "super + Escape" = "pkill -USR1 -x sxhkd";

      # lockscreen
      "shift + super + x" = "$HOME/.config/sxhkd/scripts/lock_screen.sh";
      "XF86ScreenSaver" = "$HOME/.config/sxhkd/scripts/lock_screen.sh";
      # screen
      "XF86Display" = "dmenu-screen";
      "super + F7" = "$HOME/.screenlayout/internal_monitor";
      "super + shift + F7" = "$HOME/.config/sxhkd/scripts/change_monitors.sh";
      "XF86MonBrightnessDown" = "brightnessctl set 5%-";
      "XF86MonBrightnessUp" = "brightnessctl set 5%+";
      "shift + alt + F6" = "brightnessctl set 5%-";
      "shift + alt + F7" = "brightnessctl set 5%+";
      # Multimedia
      #TODO add microphone mute
      "XF86AudioMicMute" = "wpctl set-mute @DEFAULT_SINK@ toggle";
      "XF86AudioRaiseVolume" = "wpctl set-volume @DEFAULT_SINK@ 5%+";
      "shift + XF86AudioRaiseVolume" = "wpctl set-volume @DEFAULT_SINK@ 15%+";
      "XF86AudioLowerVolume" = "wpctl set-volume @DEFAULT_SINK@ 5%-";
      "shift + XF86AudioLowerVolume" = "wpctl set-volume @DEFAULT_SINK@ 15%-";
      "XF86AudioMute" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
      "XF86AudioPlay" = "playerctl play-pause";
      "XF86Audio{Prev,Next}" = "playerctl {previous,next}";
      "super + {F12, F10, F11}" = "playerctl {play-pause,previous,next}";
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "Arc-Dark";
      "Net/IconThemeName" = "Adwaita";
      "Gtk/DecorationLayout" = "menu:minimize,maximize,close";
      # "Gtk/FontName" = "Ubuntu Regular 10";
      "Gtk/MonospaceFontName" = "Source Code Pro 10";
      #"Gtk/CursorThemeName"= "DMZ-White";
      "Xft/Hinting" = 1;
      "Xft/HintStyle" = "hintslight";
      "Xft/Antialias" = 1;
      "Xft/RGBA" = "rgb";
      # Xft/DPI 90000 ;
      #Xft/DPI 105000 ;
    };
  };

}
