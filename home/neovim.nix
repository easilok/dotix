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
    parinfer-rust
    libuv
    lua-language-server
    nixd
    nodejs_22
  ];

  # home.file.neovim-config= {
  #   source = ./dotfiles/nvim/.config/nvim;
  #   target = ".config/nvim";
  #   recursive = true;
  # };
}

