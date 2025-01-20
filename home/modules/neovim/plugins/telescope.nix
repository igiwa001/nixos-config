{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  preview_scroll = {
    "<C-h>" = "preview_scrolling_left";
    "<C-j>" = "preview_scrolling_down";
    "<C-k>" = "preview_scrolling_up";
    "<C-l>" = "preview_scrolling_right";
  };
in {
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      keymaps = {
        "<C-f>" = {action = "find_files";};
        "<C-g>" = {action = "live_grep";};
        "<C-h>" = {action = "find_files hidden=true no_ignore=true";};
      };
      settings = {
        defaults.mappings = {
          i = preview_scroll;
          n = preview_scroll;
        };
      };
    };
    web-devicons.enable = true;
  };
  home.packages = [
    pkgs.ripgrep
  ];
}
