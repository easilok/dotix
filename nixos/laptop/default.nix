{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    networkmanagerapplet
  ];

  services.blueman = {
    enable = true;
  };
}
