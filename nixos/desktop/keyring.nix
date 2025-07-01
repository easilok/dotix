{ pkgs, ... }:
{
  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    lightdm.enableGnomeKeyring = true;
    lightdm-password.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
  services.dbus.packages = [
    pkgs.gnome-keyring
    pkgs.gcr
  ];

  services.xserver.displayManager.sessionCommands = ''


    eval $(gnome-keyring-daemon --start --daemonize --components=ssh,secrets)


    export SSH_AUTH_SOCK


  '';

}
