{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim.lazy.plugins."persistence.nvim" = lib.mkIf cfg.enable {
    package = pkgs.vimPlugins.persistence-nvim;
    setupModule = "persistence";
    event = ["BufReadPre"];
  };
}
