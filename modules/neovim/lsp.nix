{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim.lsp = lib.mkIf cfg.enable {
    enable = true;
    formatOnSave = false;
    mappings.format = null;
  };
}
