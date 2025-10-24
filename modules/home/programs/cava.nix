{ inputs, myopts, ... }:
{
  programs.cava = {
    enable = myopts.additionalPackages;
    settings = {
      general.framerate = 60;
      smoothing.noise_reduction = 88;
    };
  };
}
