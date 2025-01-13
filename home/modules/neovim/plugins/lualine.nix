{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
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
}
