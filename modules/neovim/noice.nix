{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim = lib.mkIf cfg.enable {
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
