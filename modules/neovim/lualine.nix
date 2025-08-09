{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim.lualine;
in {
  options.settings.neovim.lualine.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim.statusline.lualine = lib.mkIf cfg.enable {
    enable = true;
    refresh.statusline = 16;
  };
}
