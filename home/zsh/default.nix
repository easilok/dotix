{ pkgs, shellConfig }:
let extraConfig = shellConfig.extraConfig or "";
in {
  enable = true;
  enableCompletion = true;
  # completionInit = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  defaultKeymap = "viins";
  history = {
    size = 1000000;
    save = 1000000;
    path = "$HOME/.cache/zsh/history";
    append = true;
    ignoreAllDups = true;
    ignoreDups = true;
    expireDuplicatesFirst = true;
    saveNoDups = true;
    ignoreSpace = true;
    share = true;
  };

  localVariables = shellConfig.sessionVariables;

  initContent = extraConfig + builtins.readFile ./custom-config.zsh;

  shellAliases = shellConfig.shellAliases;

  logoutExtra = shellConfig.logoutExtra;
}

