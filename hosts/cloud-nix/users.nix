{ pkgs, ... }: {
  users.users.luis = {
    isNormalUser = true;
    description = "Luis Pereira";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "dialout" ];
  };

  # imports = [
  #   ../../home/base.nix
  #   ../../home/development.nix
  # ];
}
