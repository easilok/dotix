{ pkgs, ... }:
{
  users.groups = {
    uinput = { };
  };

  users.users.luis = {
    isNormalUser = true;
    description = "Luis Pereira";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "dialout"
      "libvirtd"
      "input"
      "uinput"
    ];
  };
}
