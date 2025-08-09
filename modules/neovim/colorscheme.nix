{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim.theme;
in {
  options.settings.neovim.theme = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.settings.neovim.enable;
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = "onedark";
    };

    transparent = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.programs.nvf.settings.vim.theme = lib.mkIf cfg.enable {
    inherit (cfg) enable name transparent;
  };
}
