{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = ".zsh";

    plugins = [
      {
        # Must be before plugins that wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    initContent = lib.concatStringsSep "\n" [
      (builtins.readFile ./init.zsh)
      (builtins.readFile ./functions.zsh)
    ];

    history = {
      size = 10000;
      path = "/home/levizor/.zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "colored-man-pages"
        "copybuffer"
        "copyfile"
        "copypath"
        "extract"
        "aliases"
        "cp"
        "magic-enter"
      ];
    };

    antidote = {
      enable = true;
      plugins = [
        "belak/zsh-utils path:completion"
        "romkatv/zsh-defer"
        "getantidote/use-omz"
      ];
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
