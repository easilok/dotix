{ config, pkgs, ... }: {
  programs.git = {
    enable = true;

    userName = "Luis Pereira";
    userEmail = "luispereira.tkd@gmail.com";

    signing = {
      key = "93823504C1F5FBEE";
      signByDefault = true;
    };

    aliases = {
      aa = "add --all";
      bs = "bselect";
      bselect = "!git-branch-fzf";
      ca = "commit --amend --verbose";
      car = "commit --amend --no-edit";
      co = "checkout";
      conflicted = "!vim +Conflicted";
      copysha = "!git rev-parse HEAD | pbcopy";
      dup =
        "!git checkout develop && git fetch origin && echo && git sl develop..origin/develop && echo && git pull --quiet && git checkout -";
      fad =
        "!git add $(git ls-files --others --exclude-standard -m | fzf --reverse --multi)";
      fall = "fetch --all";
      fx = "commit --fixup";
      glog = "log -E -i --grep";
      la = "log --oneline --decorate -20";
      ll = "log --oneline --decorate";
      lla = "log --oneline --decorate --graph --all";
      ls = "log --oneline --decorate -20";
      mup =
        "!git checkout master && git fetch origin && echo && git sl master..origin/master && echo && git pull --quiet && git checkout -";
      pf = "push --force-with-lease";
      psf = "pf";
      pl = "pull";
      ps = "push";
      pro = "!pro";
      rbc = "rebase --continue";
      rba = "rebase -i --autosquash";
      rdup = "!git dup && git rebase develop";
      rid = "!git rebase -i $(git merge-base develop HEAD)";
      rim = "!git rebase -i $(git merge-base master HEAD)";
      riu =
        "!git rebase -i $(git rev-parse --abbrev-ref --symbolic-full-name @{u})";
      rmup = "!git mup && git rebase master";
      sl = "ls";
      sla = "la";
      slap = "lla";
      slp = "ll";
      todo = "!git log --format=%B -n 1 | grep -A999 '^This change$'";
      uncommit = "reset --soft HEAD^";
      unstage = "reset";
      upstream = "rev-parse --abbrev-ref --symbolic-full-name @{u}";
      ureset = "!git reset --hard $(git upstream)";
    };

    extraConfig = {
      color.ui = "auto";

      core = {
        excludesfile = "~/.gitignore";
        autocrlf = "input";
        editor = "vim";
      };

      rebase.autosquash = true;

      merge = {
        ff = "only";
        tool = "vimdiff";
      };

      push.default = "upstream";
      fetch.prune = true;

      gitsh = {
        color.default = "cyan";
        defaultcommand = "status -sb";
        gitcommand = "hub";
        nogreeting = true;
        prompt = ''

          %D %c(%b%#)%w ➜'';
      };

      credential.helper = "store";

      filter."lfs" = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };

      pull.ff = "only";

      init.defaultBranch = "main";

      commit = {
        verbose = true;
      };

      rerere.enabled = true;
    };

    includes = [{
      condition = "gitdir:~/projects/work/";
      path = "~/projects/work/.config/git/config";
    }];
  };

  # Global .gitignore
  home.file.".gitignore".text = ''
    _Store
    *.sw[nop]
    .bundle
    .byebug_history
    db/*.sqlite3
    log/*.log
    rerun.txt
    tags
    !tags/
    tmp/**/*
    !tmp/cache/.keep
    *.pyc
    vim/view

    .project-notes
    .vimrc.local
    node_modules
    .vimrc
    .nvimrc
    Sess*.vim
    proj_notes.md
  '';

}
