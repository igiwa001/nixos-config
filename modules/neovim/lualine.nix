{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim.statusline.lualine = lib.mkIf cfg.enable {
    enable = true;
    refresh.statusline = 16;
  };
}
