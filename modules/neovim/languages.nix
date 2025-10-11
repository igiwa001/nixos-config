{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.neovim;
  lang = cfg.languages;
in {
  options.settings.neovim.languages = {
    nix = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    lua = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    html = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    css = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    tailwind = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    typescript = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    c = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    markdown = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    scala = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.programs.nvf.settings.vim.languages = lib.mkIf cfg.enable {
    enableDAP = lib.mkIf cfg.lsp.enable true;
    enableFormat = lib.mkIf cfg.conform.enable true;
    enableTreesitter = lib.mkIf cfg.treesitter.enable true;
    enableExtraDiagnostics = lib.mkIf cfg.diagnostics.enable true;

    nix.enable = lib.mkIf lang.nix true;
    lua.enable = lib.mkIf lang.lua true;
    html.enable = lib.mkIf lang.html true;
    tailwind.enable = lib.mkIf lang.tailwind true;
    scala.enable = lib.mkIf lang.scala true;

    css = lib.mkIf lang.css {
      enable = true;
      format.package = pkgs.nodePackages.prettier;
    };

    ts = lib.mkIf lang.typescript {
      enable = true;
      format.package = pkgs.nodePackages.prettier;
    };

    clang = lib.mkIf lang.c {
      enable = true;
      cHeader = true;
    };

    markdown = lib.mkIf lang.markdown {
      enable = true;
      extensions.markview-nvim.enable = true;
    };
  };
}
