{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        nix = ["alejandra"];
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action = "<CMD>lua require('conform').format()<CR>";
        options = {
          noremap = true;
          silent = true;
          nowait = true;
        };
      }
    ];
  };
  home.packages = [pkgs.alejandra];
}
