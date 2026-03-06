{ pkgs, ... }:
{
  users.groups = {
    uinput = { };
  };

  programs.zsh.enable = true;

  users.users.luis = {
    isNormalUser = true;
    description = "Luis Pereira";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "dialout"
      "input"
      "uinput"
    ];
    shell = pkgs.zsh;
  };

  # imports = [
  #   ../../home/base.nix
  #   ../../home/development.nix
  # ];
}
