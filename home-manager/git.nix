{
  programs.git = {
    enable = true;
    userName = "Levizor";
    userEmail = "levizorri@gmail.com";

    extraConfig = {
      push = {
        autoSetupRemote = true; 
      };
    };
  };
}
