{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim = lib.mkIf cfg.enable {
    autocomplete.nvim-cmp = {
      enable = true;
      format = null;
      setupOpts.completion.completeopt = "menu,menuone,noselect";
    };
    ui.borders.plugins.nvim-cmp.enable = true;
  };
}
