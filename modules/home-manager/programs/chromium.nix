{ pkgs, ... }:
{
  programs.brave = {
    enable = true;
    extensions = [
      {
        # Ublock Origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
      {
        # Vimium C
        id = "hfjbmagddngcpeloejdejnfgbamkjaeg";
      }
      {
        # Vimium New Tab Adapter
        id = "cglpcedifkgalfdklahhcchnjepcckfn";
      }
      {
        # Vimum Pdf Viewer
        id = "nacjakoppgmdcpemlfnfegmlhipddanj";
      }
      {
        # KeePassXC
        id = "oboonakemofpalcgghocfoadofidjkkk";
      }
      {
        # SponsorBlock
        id = "mnjggcdmjocbbbhaepdhchncahnbgone";
      }
      {
        # DeArrow
        id = "enamippconapkdmgfgjchkhakpfinmaj";
      }
      {
        # Privacy Badger
        id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
      }
    ];
  };
}
