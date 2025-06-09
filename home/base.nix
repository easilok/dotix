# TODO: move this configuration to home-manager
{ pkgs, host-config, ... }: {
  users.users."${host-config.username}".packages = with pkgs; [
    gnumake
    gcc
    fzf
    pinentry
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
    tmux
    stow
    eza
    htop
  ];
}

