{ config, pkgs, pkgs-unstable, ... }:
{

  home.packages = with pkgs-unstable; [
    opencode
    pi-coding-agent
    # claude-code
    # codex
    # codex-acp
    # ollama
  ] ++ [
    pkgs.graphifyy
  ];
}
