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
    utility.oil-nvim.enable = true;
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
