{
  services.atticd = {
    enable = true;
    environmentFile = "/etc/atticd.env";

    settings = {
      listen = "[::]:8443";
    };
  };
}
