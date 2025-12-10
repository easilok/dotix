{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rlwrap
    sbcl
    taskwarrior3
    timewarrior
    timetagger_cli
    kanata
    go
    smug
    gh
  ];

  programs.mise = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

  imports = [
    ./neovim.nix
    ./lsp.nix
    ./ai.nix
  ];

}
