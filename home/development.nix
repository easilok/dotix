{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rlwrap
    taskwarrior3
    timewarrior
    timetagger_cli
    kanata
    sbcl
    go
  ];

  programs.mise = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

  imports = [
    ./neovim.nix
    ./lsp.nix
  ];

}
