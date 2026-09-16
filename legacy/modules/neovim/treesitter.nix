{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.settings.neovim.treesitter;
in {
  options.settings.neovim.treesitter.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
    treesitter = {
      enable = true;
      autotagHtml = true;
      fold = true;
    };

    extraPackages = [pkgs.gcc];
  };
}
