{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wezterm
    kitty
    ghostty
    flameshot
    haskellPackages.greenclip
    lxappearance
    xorg.xev
    xorg.xmodmap
    nextcloud-client
    xarchiver
    arc-theme
    pcmanfm
    libreoffice
    zathura
    evince
    speedcrunch
    wireguard-tools
  ];

  imports = [ ./fonts.nix ./rofi.nix ./window-manager ./multimedia.nix];

  systemd.user.services.greenclip = {

    Unit = { Description = "greenclip daemon"; };
    Service = {
      ExecStart = ''
        ${pkgs.haskellPackages.greenclip}/bin/greenclip daemon
      '';
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };

  xdg.systemDirs.data = [
    "/usr/share"
    "/var/lib/flatpak/exports/share"
    "$HOME/.local/share/flatpak/exports/share"
  ];

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ../dotfiles/wezterm/.config/wezterm/wezterm.lua;
    # enableBashIntegration = config.programs.bash.enable;
    # enableZshIntegration = config.programs.zsh.enable;
  };

    services.gnome-keyring = {
        enable = true;
    };
}

