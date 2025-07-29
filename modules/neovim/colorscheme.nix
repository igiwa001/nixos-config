{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim.theme = lib.mkIf cfg.enable {
    enable = true;
    name = "onedark";
    transparent = true;
  };
}
