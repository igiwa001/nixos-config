{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
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

    plugins = {
      treesitter = {
        enable = true;
        settings.indent.enable = true;
      };

      telescope = {
        enable = true;
        keymaps = {
          "<C-f>" = { action = "find_files"; };
          "<leader>fg" = { action = "live_grep"; };
        };
      };
      web-devicons.enable = true; # Look into mini.nvim

      lualine = {
        enable = true;
        settings.options = {
          globalstatus = true;
          section_separators = {
            left = "";
            right = "";
          };
        };
      };
    };

    colorschemes.tokyonight.enable = true;
  };
}
