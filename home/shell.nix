{ config, pkgs, ... }:
let

  shellAliases = {
    # General Alias
    gpg-agent-update = "gpg-connect-agent updatestartuptty /bye > /dev/null";
    "vi" = "vim";
    "vs" = "nvim +Sassy";
    # info
    "battery" = "acpi -V | sed -n -e 1p -e 4p";
    "a" = "alias";
    "cp" = "cp -i";

    # Directory Alias
    "dir" = "dir --color=auto";
    "vdir" = "vdir --color=auto";
    "grep" = "grep --color=auto";
    "fgrep" = "fgrep --color=auto";
    "egrep" = "egrep --color=auto";
    "rgrep" = "rgrep --color=auto";

    # listing directories
    # "ls" = "ls --color=auto"; # detailed list, show hidden
    # "l" = "ls -la"; # detailed list, show hidden
    # "lh" = "ls -lah"; # detailed list, show hidden, human filesizes
    # "ll" = "ls -lrth"; # detailed list, no hidden
    # "ls." = "ls -d .[^.]*"; # regular list, only hidden
    # "ll." = "ls -ld .[^.]*"; # detailed list, only hidden
    # "lsd" = "ls -d *(-/DN)"; # regular list, only directories
    # "lld" = "ls -ld *(-/DN)"; # detailed list, only directories

    "d" = "dirs -v"; # list directory stack

    # size
    "du" = "du -shc";
    "df" = "df -h";

    # git
    "g" = "git-safer";
    # "git"="git-safer";
    "gs" = "git status";
    "ga" = "git add";
    "gp" = "git push";
    "gr" = "git branch -r";
    "gb" = "git branch ";
    "gc" = "git commit";
    "gd" = "git diff";
    "gco" = "git switch ";
    "gls" = "git ls";
    "gg" = ''
      git log --graph --full-history --date=relative --color --pretty=format:"%C(yellow)%h  %C(cyan)%ad %Cgreen[ %aN ] %Creset%s %C(bold yellow)%d" --graph'';
    "glo" = "git log --pretty=oneline";
    "glol" = "git log --graph --oneline --decorate";
    "grs" = "git remote show";
    "co" = "git bs";

    # Path Alias
    "config" = "cd ~/.config";
    "dotfiles" = "cd ~/git/dotfiles";

    # project
    "cdp" = "cd $(tmux-sessionizer --path-only)";
    "tp" = "tmux-sessionizer";
    "trp" = "tmux-resumer";
    "va" = "source venv/bin/activate || source .venv/bin/activate";
    # System
    "volume-up" =
      "cat $HOME/.config/sxhkd/sxhkdrc | grep -A1 -m 1 XF86AudioRaiseVolume | grep -v XF86AudioRaiseVolume | sh";
    "volume-down" =
      "cat $HOME/.config/sxhkd/sxhkdrc | grep -A1 -m 1 XF86AudioLowerVolume | grep -v XF86AudioLowerVolume | sh";

  };

in {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''

      export HISTTIMEFORMAT="%F %T "

      set -o vi
      set +o noclobber

      source $HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh
      export GIT_PS1_SHOWDIRTYSTATE=1;

      export PS1="\[\e[38;5;39m\]\u\[\e[38;5;81m\]@\[\e[38;5;77m\]\h \[\e[38;5;195m\]\w \[\e[38;5;220m\]$(__git_ps1 "(%s) ")\n\[\e[38;5;141m\]$ \[\033[0m\]"
    '';

    sessionVariables = {

      EDITOR = "vim";
      TERMINAL = "wezterm";

      _JAVA_AWT_WM_NONREPARENTING = 1;

      XDG_CONFIG_HOME = "$HOME/.config";

    };

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

    shellAliases = shellAliases;

    logoutExtra = ''
      # ~/.bash_logout: executed by bash(1) when login shell exits.

      # when leaving the console clear the screen to increase privacy

      if [ "$SHLVL" = 1 ]; then
          [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
      fi
    '';

  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    # enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    # enableZshIntegration = true;
  };

  programs.starship = {
    enable = false;
    enableBashIntegration = false;
    # enableZshIntegration = true;
  };

}

