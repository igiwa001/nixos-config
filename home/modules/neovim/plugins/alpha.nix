{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  makeButton = {command, desc, shortcut}: {
    type = "button";
    val = desc;
    opts = {
      inherit shortcut;
      keymap = [
        "n" shortcut command
        {
          noremap = true;
          silent = true;
          nowait = true;
        }
      ];
      position = "center";
      width = 35;
      cursor = 3;
      align_shortcut = "right";
    };
  };
in
{
  programs.nixvim.plugins.alpha = {
    enable = true;
    layout = [
      {
        type = "padding";
        val = 5;
      }
      {
        type = "text";
        opts = {
          hl = "AlphaHeader";
          position = "center";
        };
        val  = [
          "                                              "
          "      ████ ██████           █████      ██"
          "     ███████████             █████ "
          "     █████████ ███████████████████ ███   ███████████"
          "    █████████  ███    █████████████ █████ ██████████████"
          "   █████████ ██████████ █████████ █████ █████ ████ █████"
          " ███████████ ███    ███ █████████ █████ █████ ████ █████"
          "██████  █████████████████████ ████ █████ █████ ████ ██████"
        ];
      }
      {
        type = "padding";
        val = 5;
      }
      {
        type = "group";
        opts = {
          hl = "AlphaButtons";
          position = "center";
          spacing = 1;
        };
        val = map makeButton [
          { 
            desc = "󰈞  Find file";
            shortcut = "f";
            command = "<CMD>Telescope find_files<CR>";
          }
          { 
            desc = "󰈬  Find text";
            shortcut = "g";
            command = "<CMD>Telescope live_grep<CR>";
          }
          { 
            desc = "  Recent files";
            shortcut = "r";
            command = "<CMD>Telescope oldfiles<CR>";
          }
          { 
            desc = "  Restore session";
            shortcut = "s";
            command = "<CMD>lua require('persistence').load()<CR>";
          }
          { 
            desc = "󰅚  Quit";
            shortcut = "q";
            command = "<CMD>qa<CR>";
          }
        ];
      }
    ];
  };
}
