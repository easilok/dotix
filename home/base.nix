# TODO: move this configuration to home-manager
{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # file mgmt
    unzip
    zip
    bash-completion
    findutils
    gzip
    pbzip2 # multi core replacement for bzip2/bunzip2
    diffutils
    # console tools
    bc # calculator
    pass
    jq
    ripgrep
    stow
    eza
    htop
    home-manager
    tmux # required for allowing using my own config
  ];

  # TODO: Move to tmux configuration
  # programs.tmux = { enable = true; };
  home.file.".config/tmux/tmux.conf" = {
    source = ./dotfiles/tmux/.config/tmux/tmux.conf;
  };
}

