{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      neo-tree.enable = true;
      web-devicons.enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<C-n>";
        action = "<CMD>Neotree toggle<CR>";
      }
    ];
  };
}
