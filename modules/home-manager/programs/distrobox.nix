{
  programs.distrobox = {
    enable = true;
    containers = {
      aur = {
        image = "archlinux:latest";
      };
    };
  };
}
