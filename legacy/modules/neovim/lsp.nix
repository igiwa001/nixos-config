{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim.lsp;
in {
  options.settings.neovim.lsp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.settings.neovim.enable;
    };

    formatOnSave = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config.programs.nvf.settings.vim.lsp = lib.mkIf cfg.enable {
    enable = true;
    mappings.format = null;
    inherit (cfg) formatOnSave;
  };
}
