{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim = lib.mkIf cfg.enable {
    formatter.conform-nvim.enable = true;
  };
}
