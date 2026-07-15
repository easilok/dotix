{ pkgs, ... }:
{
  users.groups = {
    uinput = { };
  };

  # programs.zsh.enable = true;

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
    shell = "/home/luis/.guix-home/profile/bin/zsh";
    # shell = pkgs.zsh;
  };
}
