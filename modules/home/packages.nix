{
  inputs,
  config,
  lib,
  pkgs,
  myopts,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  home.packages =
    let
      stable = import inputs.stable {
        config = config.nixpkgs.config;
        system = pkgs.system;
      };
    in
    with pkgs;
    [
      duf
      bat
      cmatrix
      ffmpeg
      fzf
      loupe
      ripgrep
      telegram-desktop
      tlrc
      neovim-remote
      typst
    ]
    ++ lib.optionals myopts.additionalPackages [
      # inputs.tray-tui.packages.${system}.tray-tui
      tray-tui
      inputs.dark-text.packages.${system}.default
      # android-tools
      ani-cli
      cargo
      # filezilla
      hyprland-workspaces-tui
      jetbrains.rider
      jetbrains-toolbox
      # jetbrains.idea-ultimate
      stable.jetbrains.pycharm-professional
      pinta
      networkmanagerapplet
      nix-prefetch-github
      obsidian
      onlyoffice-desktopeditors
      qbittorrent
      thunderbird
      timg
      ungoogled-chromium
      vesktop
      youtube-music
      yt-dlp
      lazygit
      gemini-cli
      fd
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

}
