{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim.noice;
in {
  options.settings.neovim.noice.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
    ui.noice = {
      enable = true;
      setupOpts = {
        lsp.signature.enabled = true;
        presets.lsp_doc_border = true;
      };
    };

    notify.nvim-notify = {
      enable = true;
      setupOpts = {
        background_colour = "#000000";
        timeout = 3000;
      };
    };
  };
}
