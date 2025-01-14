{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      settings = {
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>nd";
        action = "<CMD>Noice dismiss<CR>";
      }
    ];
  };
}
