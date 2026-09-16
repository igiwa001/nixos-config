{
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.btop;
in {
  options.settings.programs.btop.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.programs.btop = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      color_theme = "onedark";
      theme_background = false;
      truecolor = true;
      vim_keys = true;
      graph_symbol = "braille";
      update_ms = 200;
      proc_sorting = "cpu lazy";
      proc_cpu_graphs = false;
      cpu_single_graph = true;
      show_coretemp = false;
      io_mode = true;
    };
  };
}
