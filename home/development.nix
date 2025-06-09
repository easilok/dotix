# TODO: move this configuration to home-manager
{ pkgs, host-config, ... }: {
  users.users."${host-config.username}".packages = with pkgs; [
    neovim
    tree-sitter
    parinfer-rust
    libuv
    lua-language-server
    nixd
    nodejs_22
    starship
    zoxide
    zsh
    mise
  ];
}

