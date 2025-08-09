{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.neovim.diagnostics;
in {
  options.settings.neovim.diagnostics.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim.lazy.plugins."tiny-inline-diagnostic.nvim" = lib.mkIf cfg.enable {
    package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
    setupModule = "tiny-inline-diagnostic";
    setupOpts = {
      preset = "modern";
      options = {
        show_source.enabled = true;
        multilines = true;
        show_all_diags_on_cursorline = true;
        throttle = 0;
      };
    };
  };
}
