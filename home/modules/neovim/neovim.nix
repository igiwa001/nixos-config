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
