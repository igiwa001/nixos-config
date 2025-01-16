{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
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

    colorschemes.tokyonight.enable = true;
  };
}
