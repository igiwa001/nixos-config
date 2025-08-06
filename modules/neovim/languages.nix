{
  lib,
  config,
  pkgs,
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
      format.package = pkgs.nodePackages.prettier;
    };

    ts = {
      enable = true;
      format.package = pkgs.nodePackages.prettier;
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
