{ config, lib, pkgs, nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.dell-latitude-7420
  ];

  hardware.bluetooth.enable = true;

  # setup backlight ownership and permissions to video group
  # services = {
  #   xserver.synaptics.enable = false;
  # };
}
