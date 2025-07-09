{
  shellAliases = {
    # General Alias
    gpg-agent-update = "gpg-connect-agent updatestartuptty /bye > /dev/null";
    "v" = "nvim";
    "vim" = "nvim";
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
    "mk" = "() { mkdir -p $1 && cd $1 }";

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
    "gs" = "git status --short";
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

    # Taskwarrior
    "t" = "task";
    "work" = "task context work && task";
    "p" = "task context personal && task";
    "tt" = "work today";
    "day-progress" = "task end.after:yesterday completed";

  };

  sessionVariables = {

    EDITOR = "vim";
    TERMINAL = "wezterm";

    _JAVA_AWT_WM_NONREPARENTING = 1;

    XDG_CONFIG_HOME = "$HOME/.config";

  };

  logoutExtra = ''
    if [ "$SHLVL" = 1 ]; then
        [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
    fi
  '';
}
