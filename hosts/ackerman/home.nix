{ config, pkgs, ... }:
{
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  imports = [
    ../../home/base.nix
    ../../home/cli-extra.nix
    ../../home/shell
    ../../home/git.nix
    ../../home/development.nix
    ../../home/development-extra.nix
    ../../home/desktop
  ];

  home.packages = with pkgs; [
    devede
    sbcl_2_4_10
  ];

  home.sessionVariables = {
    SBCL_HOME="/home/luis/.nix-profile/lib/sbcl";
  };

  home.file.".Xmodmap" = {
    text = ''
      clear lock
      keycode  21 = less greater less greater guillemotleft guillemotright guillemotleft
      keycode  66 = Escape Escape Escape Escape
      keysym XF86Back = Home
      keysym XF86Forward = End
    '';
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
