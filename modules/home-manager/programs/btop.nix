{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      force_tty = true;
      proc_tree = true;
      proc_aggregate = true;
      proc_sorting = "memory";
      shown_boxes = "proc cpu mem";
    };
  };
}
