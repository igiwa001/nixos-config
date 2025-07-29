{
  lib,
  config,
  ...
}: let
  cfg = config.settings.neovim;
in {
  programs.nvf.settings.vim.languages = lib.mkIf cfg.enable {
    enableDAP = true;
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    nix.enable = true;
    ts = {
      enable = true;
      format.type = "prettierd";
    };
  };
}
