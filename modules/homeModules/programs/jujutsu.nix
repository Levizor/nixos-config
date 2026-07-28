{
  flake.homeModules.jujutsu = { myopts, ... }: {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = myopts.git.user;
          email = myopts.git.email;
        };
      };
    };
  };
}
