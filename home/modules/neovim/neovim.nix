{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins/performance.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/lualine.nix
    ./plugins/persistence.nix
    ./plugins/alpha.nix
    ./plugins/noice.nix
    ./plugins/neo-tree.nix
    ./plugins/indent-blankline.nix
    ./plugins/comment.nix
    ./plugins/nvim-autopairs.nix
    ./plugins/conform.nix
    ./plugins/cmp.nix
    ./plugins/lsp.nix
  ];

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";
    opts = {
      expandtab = true;
      smartindent = true;
      tabstop = 2;
      shiftwidth = 2;
      relativenumber = true;
    };

    colorscheme = "duskfox";
    colorschemes.nightfox = {
      enable = true;
      settings = {
        options = {
          terminal_colors = true;
          transparent = true;
          styles = {
            comments = "italic";
            functions = "bold";
          };
        };
      };
    };
  };
}
