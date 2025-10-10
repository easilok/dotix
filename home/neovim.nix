{ config, pkgs, ... }:
let
  vimPlug = pkgs.fetchFromGitHub {
    owner = "junegunn";
    repo = "vim-plug";
    rev = "0.14.0";
    sha256 = "sha256-d8LZYiJzAOtWGIXUJ7788SnJj44nhdZB0mT5QW3itAY=";
  };
in {

  home.file.".local/share/nvim/site/autoload/plug.vim" = {
    source = "${vimPlug}/plug.vim";
  };

  home.packages = with pkgs; [
    neovim
    tree-sitter
    libuv
    nodejs_22
    # lsp and formatters
    nixd
    nixfmt-rfc-style
    parinfer-rust
    lua-language-server
    pyright
    basedpyright
    fennel
    fennel-ls
    fnlfmt
  ];

  # home.file.neovim-config= {
  #   source = ./dotfiles/nvim/.config/nvim;
  #   target = ".config/nvim";
  #   recursive = true;
  # };
}

