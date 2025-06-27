{ config, pkgs, ... }: {
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  imports = [
      ../../home/base.nix
      ../../home/shell
      ../../home/git.nix
      ../../home/development.nix
      ../../home/desktop
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

