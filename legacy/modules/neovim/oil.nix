{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim.oil;
in {
  options.settings.neovim.oil.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
    utility.oil-nvim = {
      enable = true;
      setupOpts.win_options = {
        winbar = "%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}";
        winblend = 0;
      };
    };

    keymaps = [
      {
        key = "-";
        action = "<CMD>Oil<CR>";
        mode = "n";
        silent = true;
        nowait = true;
      }
    ];
  };
}
