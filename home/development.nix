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

  programs.direnv = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    nix-direnv.enable = true;
  };

  # services.lorri.enable = true;

  imports = [
    ./neovim.nix
    ./lsp.nix
    ./ai.nix
  ];

}
