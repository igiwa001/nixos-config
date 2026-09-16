{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim.conform;
in {
  options.settings.neovim.conform.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
    formatter.conform-nvim = {
      enable = true;
      setupOpts.formatters_by_ft = {
        json = ["prettier"];
      };
    };

    keymaps = [
      {
        key = "<leader>lf";
        action = "require('conform').format";
        mode = "n";
        silent = true;
        nowait = true;
        lua = true;
      }
    ];
  };
}
