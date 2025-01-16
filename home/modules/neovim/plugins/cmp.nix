{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  border = [
    "┌"
    "─"
    "┐"
    "│"
    "┘"
    "─"
    "└"
    "│"
  ];
in {
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {name = "nvim_lsp";}
          {name = "treesitter";}
          {name = "buffer";}
        ];
        window = {
          completion.border = border;
          documentation.border = border;
        };
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm()";
          "<C-c>" = "cmp.mapping.abort()";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
      };
    };
    cmp-treesitter.enable = true;
  };
}
