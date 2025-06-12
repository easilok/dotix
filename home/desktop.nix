{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wezterm
    flameshot
    rofi
  ];

  xsession.windowManager.i3 = {
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
}


