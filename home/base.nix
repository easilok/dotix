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
    htop
    tmux # required for allowing using my own config
    lf
  ];

  # TODO: Move to tmux configuration
  # programs.tmux = { enable = true; };
  home.file.".config/tmux/tmux.conf" = {
    source = ./dotfiles/tmux/.config/tmux/tmux.conf;
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.file.".local/bin" = {
    source = ./dotfiles/bin/.local/bin;
    recursive = true;
  };

}

