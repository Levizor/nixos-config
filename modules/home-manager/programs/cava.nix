{inputs, ...}:
{
  programs.cava = {
    enable = false;
    settings = {
      general.framerate = 60;
      smoothing.noise_reduction = 88;
    };
  };
}
