{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.neovim.persistence;
in {
  options.settings.neovim.persistence.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim.lazy.plugins."persistence.nvim" = lib.mkIf cfg.enable {
    package = pkgs.vimPlugins.persistence-nvim;
    setupModule = "persistence";
    event = ["BufReadPre"];
  };
}
