{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wezterm
    flameshot
    haskellPackages.greenclip
    lxappearance
  ];

  imports = [ ./fonts.nix ./rofi.nix ./window-manager.nix ./multimedia.nix];

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

}

