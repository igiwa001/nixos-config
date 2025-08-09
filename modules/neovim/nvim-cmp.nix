{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim.nvim-cmp;
in {
  options.settings.neovim.nvim-cmp.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
    autocomplete.nvim-cmp = {
      enable = true;
      format = null;
      setupOpts.completion.completeopt = "menu,menuone,noselect";
    };
    ui.borders.plugins.nvim-cmp.enable = true;
  };
}
