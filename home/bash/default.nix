{ config, pkgs, ... }: 
let
  shellConfig = import ../shell/shellConfig.nix;
  extraConfig = shellConfig.extraConfig or "";
in {

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = extraConfig + ''

      export HISTTIMEFORMAT="%F %T "

      set -o vi
      set +o noclobber

      source $HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh

      export PS1="\[\e[38;5;39m\]\u\[\e[38;5;81m\]@\[\e[38;5;77m\]\h \[\e[38;5;195m\]\w\[\e[38;5;220m\]\$(__git_ps1)\n\[\e[38;5;141m\]$ \[\033[0m\]"
    '';

    sessionVariables = shellConfig.sessionVariables;

    shellOptions = [
      "autocd"
      "cdable_vars"
      "cdspell"
      "checkwinsize"
      "cmdhist"
      "dirspell"
      "dotglob"
      "expand_aliases"
      "extglob"
      "globstar"
      "histappend"
    ];

    shellAliases = shellConfig.shellAliases;

    logoutExtra = ''
      # ~/.bash_logout: executed by bash(1) when login shell exits.
      # when leaving the console clear the screen to increase privacy

    '' + shellConfig.logoutExtra;
  };

}
