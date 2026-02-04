{ inputs, ... }:
{
  flake.homeModules.packages =

    {
      config,
      lib,
      pkgs,
      myopts,
      ...
    }:
    let
      system = pkgs.system;
      stable = import inputs.stable {
        config = config.nixpkgs.config;
        system = system;
      };
    in
    {
      nixpkgs.config.allowUnfree = true;
      programs.nix-search-tv = {
        enable = true;
        enableTelevisionIntegration = true;
      };

      programs.television = {
        enable = true;
        enableZshIntegration = true;
      };

      home.packages =
        with pkgs;
        [
          duf
          fd
          bat
          cmatrix
          ffmpeg
          fzf
          ripgrep
          tlrc
          neovim-remote
          typst
          cachix
        ]
        ++ lib.optionals myopts.additionalPackages [
          telegram-desktop
          heroic
          inputs.tray-tui.packages.${system}.tray-tui
          # tray-tui
          inputs.dark-text.packages.${system}.default
          # android-tools
          ani-cli
          cargo
          # filezilla
          hyprland-workspaces-tui
          jetbrains.rider
          jetbrains-toolbox
          # jetbrains.idea-ultimate
          jetbrains.pycharm
          pinta
          networkmanagerapplet
          nix-prefetch-github
          obsidian
          onlyoffice-desktopeditors
          qbittorrent
          thunderbird
          timg
          # ungoogled-chromium
          vesktop
          pear-desktop
          yt-dlp
          lazygit
          gemini-cli
          # blender
          # prismlauncher
        ];

      home.file.".ideavimrc".text = ''

        set clipboard=unnamedplus
        set relativenumber
        set quickscope
        let mapleader=" "
        set undofile

        map <Leader>pf <action>(com.mituuz.fuzzier.Fuzzier)
        map <Leader>mf <action>(com.mituuz.fuzzier.FuzzyMover)
        map <Leader>ff <action>(com.mituuz.fuzzier.FuzzierVCS)
        map <Leader>g <action>(com.mituuz.fuzzier.FuzzyGrep)
        map <Leader>x :bd!<CR>

        map > >gv
        map < <gv

        map <C-d> <C-d>zz
        map <C-u> <C-u>zz

        map n nzzzv
        map N Nzzzv

        map <Leader>bn :bnext<CR>
        map <Leader>bp :bprev<CR>

        nmap <C-h> :action KJumpAction.Word0<cr>
        nmap <C-l> :action KJumpAction.Line<cr>
      '';

    };
}
