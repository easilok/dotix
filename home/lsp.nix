{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    parinfer-rust
    lua-language-server
    pyright
    basedpyright
    fennel
    fennel-ls
    fnlfmt
    typescript-language-server
    vscode-langservers-extracted
    typescript
    gopls
    yamlfmt
  ];
}

