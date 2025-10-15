{
  xdg.autostart.enable = true;
  programs.keepassxc = {
    enable = true;
    autostart = true;
    # settings = {
    #   General.MinimizeAfterUnlock = false;
    #   Browser = {
    #     Enabled = true;
    #     UpdateBinaryPath = false;
    #   };
    #   FdoSecrets = {
    #     ConfirmAccessItem = true;
    #     Enabled = true;
    #   };
    #   GUI = {
    #     ColorPasswords = true;
    #     MinimizeOnClose = true;
    #     MinimizeToTray = true;
    #     ShowTrayIcon = true;
    #     TrayIconAppearance = "monochrome-light";
    #   };
    #
    #   SSHAgent.Enabled = true;
    # };
  };
}
