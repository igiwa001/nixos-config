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
    lua.enable = true;
    html.enable = true;
    tailwind.enable = true;

    css = {
      enable = true;
      format.type = "prettierd";
    };

    ts = {
      enable = true;
      format.type = "prettierd";
    };

    clang = {
      enable = true;
      cHeader = true;
    };

    markdown = {
      enable = true;
      extensions.markview-nvim.enable = true;
    };
  };
}
