{ self, ... }:
{
  flake.homeModules.fish =
    {
      config,
      pkgs,
      lib,
      myopts,
      system,
      ...
    }:
    let
      copy = lib.getExe self.packages.${system}.clip-copy;
      paste = lib.getExe self.packages.${system}.clip-paste;
    in
    {
      imports = [
        self.homeModules.shell-aliases
      ];


      programs.fish = {
        enable = true;

        # ── Plugins ───────────────────────────────────────────────────────────
        # Zsh → Fish plugin equivalents:
        #   fzf-tab          → fzf-fish (fzf-powered completion, Ctrl-R, Ctrl-T)
        #   zsh-autosuggestions → built-in fish feature (ghost text)
        #   fast-syntax-highlighting → built-in fish feature
        #   historySubstringSearch   → built-in fish feature (Up arrow)
        #   sudo (OMZ)       → plugin-sudope (double Escape prepends sudo)
        #   colored-man-pages (OMZ) → colored-man-pages fish plugin
        #   copybuffer (OMZ) → Ctrl-O bound below via clip-copy
        #   copyfile/copypath (OMZ) → custom functions via clip-copy
        #   extract (OMZ)    → implemented as a custom function below
        #   cp (OMZ)         → aliased to rsync in shellAbbrs (see aliases.nix)
        #   magic-enter (OMZ) → reproduced via __magic_enter_or_execute below
        plugins = [
          # fzf-fish: fzf-powered tab completion + Ctrl-R history + Ctrl-T file search
          {
            name = "fzf-fish";
            src = pkgs.fishPlugins.fzf-fish.src;
          }
          # plugin-sudope: double Escape prepends sudo (equivalent to OMZ sudo plugin)
          {
            name = "plugin-sudope";
            src = pkgs.fishPlugins.plugin-sudope.src;
          }
          # colored-man-pages: colorized man pages
          {
            name = "colored-man-pages";
            src = pkgs.fishPlugins.colored-man-pages.src;
          }
          # z: directory jumping (complementary to zoxide, same feel as zsh z plugin)
          {
            name = "z";
            src = pkgs.fishPlugins.z.src;
          }
        ];

        # ── Interactive shell init ────────────────────────────────────────────
        interactiveShellInit = lib.concatStringsSep "\n" [
          # Source ported shell functions
          (builtins.readFile ./functions.fish)

          # ── Syntax highlighting colors ──────────────────────────────────────
          # Set correct command syntax highlighting color to green (mirrors zsh)
          ''
            set -g fish_color_command green
          ''

          # ── fzf-fish configuration ─────────────────────────────────────────
          # Mirrors the zstyle ':fzf-tab:*' and _fzf_compgen_* settings from zsh
          ''
            set -gx FZF_DEFAULT_OPTS "--height=100% --layout=reverse --no-border --preview-window=right:50%:wrap:border-none"

            # Use fd for path generation (mirrors _fzf_compgen_path / _fzf_compgen_dir)
            set -gx FZF_DEFAULT_COMMAND "fd --hidden --exclude .git"
            set -gx FZF_CTRL_T_COMMAND "fd --hidden --exclude .git"
            set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --exclude .git"

            # fzf-fish directory preview (mirrors fzf-tab zstyle cd preview)
            set -gx fzf_preview_dir_cmd "lsd --group-directories-first -1 --color=always"

            # fzf-fish file preview (uses timg for images and bat for code/text)
            set -gx fzf_preview_file_cmd 'case "$(file --mime-type -b {})" in image/*) timg -g 60x30 {} ;; *) bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {} ;; esac'
          ''

          # ── tmux fzf popup (only on desktop, mirrors myopts.server guard) ──
          (lib.optionalString (!myopts.server) ''
            set -gx FZF_TMUX 1
            set -gx FZF_TMUX_OPTS "-p80%,60%"
            set -gx fzf_tmux_opts -p 80%,60%
          '')

          # ── Key bindings ───────────────────────────────────────────────────
          # Equivalent of zsh keybindings:
          #   ^e → edit-command-line   (edit_command_buffer in fish)
          #   ^O → copybuffer          (clip-copy commandline)
          #   Enter on empty line      (magic-enter: run lsd)
          ''
            function fish_user_key_bindings
                # fzf.fish bindings: Ctrl+F for file search, Ctrl+R history, Ctrl+G git log, Ctrl+S git status
                if type -q fzf_configure_bindings
                    fzf_configure_bindings --directory=\cf --history=\cr --git_log=\cg --git_status=\cs --processes=\cp
                else if type -q fzf_key_bindings
                    fzf_key_bindings
                end

                # Tab key: pipe all Fish command completions (jj, git, flags, etc.) into FZF (fzf-tab experience)
                bind \t _fzf_complete

                # Ctrl-E: open current command in $EDITOR (mirrors zsh ^e edit-command-line)
                bind \ce edit_command_buffer

                # Ctrl-O: copy current command line to clipboard (OMZ copybuffer plugin)
                bind \co '__copybuffer'

                # Magic Enter: run lsd on empty command line (OMZ magic-enter plugin)
                bind \r '__magic_enter_or_execute'

                # Ctrl-W: delete word stopping at /, ., - (mirrors custom my-backward-delete-word)
                bind \cw backward-kill-path-component

                # Esc-l: run ls (mirrors zsh bindkey -s '\el' 'ls\n')
                bind \el 'commandline "lsd"; commandline -f execute'
            end
          ''

          # ── _fzf_complete function (fzf-tab equivalent for Fish) ────────────
          ''
            function _fzf_complete -d "Complete current token using fzf"
                set -l token (commandline -ct)
                set -l cmd (commandline -cp)
                set -l completions (complete -C"$cmd")

                if test (count $completions) -eq 0
                    return
                end

                if test (count $completions) -eq 1
                    set -l item (string split \t $completions[1])[1]
                    commandline -t -- "$item"
                    return
                end

                set -l fzf_cmd fzf
                if test -n "$TMUX"; and test -n "$fzf_tmux_opts"
                    set fzf_cmd fzf-tmux $fzf_tmux_opts
                end

                set -l selected (printf "%s\n" $completions | $fzf_cmd --query="$token" --select-1 --exit-0 | string split \t)[1]

                if test -n "$selected"
                    commandline -t -- "$selected"
                end
                commandline -f repaint
            end
          ''

          # ── copybuffer function (OMZ copybuffer equivalent) ────────────────
          ''
            function __copybuffer
                commandline | ${copy}
            end
          ''

          # ── magic-enter function (OMZ magic-enter equivalent) ──────────────
          # Runs lsd (or lsd for git repos) when Enter is pressed on empty line
          ''
            function __magic_enter_or_execute
                set -l cmd (string trim (commandline))
                if test -z "$cmd"
                    commandline "lsd"
                    commandline -f execute
                else
                    commandline -f execute
                end
            end
          ''

          # ── copypath / copyfile functions (OMZ equivalents) ─────────────────
          ''
            function copypath
                realpath (pwd) | ${copy}
                echo "Copied: $(realpath (pwd))"
            end

            function copyfile
                if test (count $argv) -eq 0
                    echo "Usage: copyfile <file>"
                    return 1
                end
                ${copy} < $argv[1]
                echo "Copied contents of: $argv[1]"
            end
          ''

          # ── Source local impure overrides (mirrors ~/.zsh/impure.zsh) ──────
          ''
            set -l _impure_fish ~/.config/fish/impure.fish
            if not test -f $_impure_fish
                touch $_impure_fish
            end
            source $_impure_fish
          ''
        ];
      };

      programs.lsd.enable = true;
      programs.zoxide.enableFishIntegration = true;
      programs.dircolors.enable = true;
      programs.fzf.enable = true;
      programs.fzf.enableFishIntegration = true;
    };
}
