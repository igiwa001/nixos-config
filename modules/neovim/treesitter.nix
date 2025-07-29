{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim = lib.mkIf cfg.enable {
    treesitter = {
      enable = true;
      autotagHtml = true;
      fold = true;
    };

    extraPackages = [pkgs.gcc];
  };
}
