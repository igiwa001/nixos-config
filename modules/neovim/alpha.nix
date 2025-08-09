{
  lib,
  config,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  cfg = config.settings.neovim.alpha;
  mkButton = {
    command,
    shortcut,
    text,
  }: {
    type = "button";
    val = text;
    on_press = mkLuaInline ''
      function()
        local key = vim.api.nvim_replace_termcodes("${command}", true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
      end
    '';
    opts = {
      inherit shortcut;
      keymap = [
        "n"
        shortcut
        command
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
in {
  options.settings.neovim.alpha.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim.dashboard.alpha = lib.mkIf cfg.enable {
    enable = true;
    theme = null;
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
        val = [
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
        val = map mkButton [
          {
            text = "󰈞  Find file";
            shortcut = "f";
            command = "<CMD>Telescope find_files<CR>";
          }
          {
            text = "󰈬  Find text";
            shortcut = "g";
            command = "<CMD>Telescope live_grep<CR>";
          }
          {
            text = "  Recent files";
            shortcut = "r";
            command = "<CMD>Telescope oldfiles<CR>";
          }
          {
            text = "  Restore session";
            shortcut = "s";
            command = "<CMD>lua require('persistence').load()<CR>";
          }
          {
            text = "󰅚  Quit";
            shortcut = "q";
            command = "<CMD>qa<CR>";
          }
        ];
      }
    ];
  };
}
