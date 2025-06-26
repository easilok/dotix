{ config, pkgs, ... }:

{
  services.guix = {
    enable = true;
    gc = {
      enable = true;
      dates = "weekly";
      extraArgs = [ "--delete-generations=1m" "--optimize" ];
    };
  };
}
