{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./users.nix ../../nixos/common.nix ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.grub.enableCryptodisk = true;

  networking.hostName = "vm-nix";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Enabling i3
  services.xserver.windowManager.i3.enable = true;
  security.pam.services = {
      i3lock-color.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Install firefox.
  programs.firefox.enable = true;

  #programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

}
