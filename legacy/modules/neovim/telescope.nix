{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.settings.neovim.telescope;
in {
  options.settings.neovim.telescope.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.settings.neovim.enable;
  };

  config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
    telescope = {
      enable = true;
      setupOpts.defaults = {
        color_devicons = true;
        selection_caret = "> ";
        path_display = ["truncate"];
        sorting_strategy = "descending";
        layout_config = {
          height = 0.9;
          width = 0.9;
          horizontal = {
            preview_width = 0.6;
            prompt_position = "bottom";
          };
        };

        mappings = let
          ni = {
            "<C-h>" = "preview_scrolling_left";
            "<C-j>" = "preview_scrolling_down";
            "<C-k>" = "preview_scrolling_up";
            "<C-l>" = "preview_scrolling_right";
            "<Tab>" = "move_selection_previous";
            "<S-Tab>" = "move_selection_next";
            "<C-u>" = false;
            "<C-d>" = false;
            "<C-f>" = false;
            "<C-t>" = false;
            "<C-q>" = false;
            "<M-q>" = false;
            "<M-f>" = false;
            "<M-k>" = false;
          };
        in {
          n = ni;
          i =
            {
              "<C-n>" = false;
              "<C-p>" = false;
              "<C-r><C-w>" = false;
              "<C-r><C-a>" = false;
              "<C-r><C-f>" = false;
              "<C-r><C-l>" = false;
            }
            // ni;
        };
      };
    };

    visuals.nvim-web-devicons = {
      enable = true;
      setupOpts.color_icons = true;
    };

    extraPackages = [
      pkgs.ripgrep
      pkgs.fd
    ];
  };
}
