{ config, pkgs, pkgs-unstable, ... }:
{

  home.packages = with pkgs-unstable; [
    opencode
    claude-code
    codex
    codex-acp
    ollama
  ];
}
