{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  options.settings.neovim = {
    indent-blankline.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable;
    };

    cellular-automaton.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable;
    };
  };

  config.programs.nvf.settings.vim.visuals = lib.mkIf cfg.enable {
    indent-blankline = lib.mkIf cfg.indent-blankline.enable {
      enable = true;
      setupOpts.scope.enabled = false;
    };
    cellular-automaton.enable = lib.mkIf cfg.cellular-automaton.enable true;
  };
}
