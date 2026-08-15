# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixos-hardware, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # nixos-hardware.nixosModules.dell-latitude-7420
    ./users.nix
    ../../nixos/hardware/latitude-7420
    ../../nixos/common.nix
    ../../nixos/desktop
    ../../nixos/laptop
    ../../nixos/virtualization
    ../../nixos/guix.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-b0df3d72-e916-4c3b-bb66-ade24c788751".device =
    "/dev/disk/by-uuid/b0df3d72-e916-4c3b-bb66-ade24c788751";
  networking.hostName = "trafalgar";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 7227 ];
    # openFirewall = false; # Use custom firewall rules
    settings = {
      LogLevel = "VERBOSE";
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Power management
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
}
