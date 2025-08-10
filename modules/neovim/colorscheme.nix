{
  lib,
  config,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  cfg = config.settings.neovim.theme;
in {
  options.settings.neovim.theme = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.settings.neovim.enable;
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = "onedark";
    };

    transparent = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
    theme = {
      inherit (cfg) enable name transparent;
    };

    autocmds = [
      {
        desc = "Link Winbar highlight to Normal";
        event = ["VimEnter" "ColorScheme"];
        callback = mkLuaInline ''
          function()
            vim.api.nvim_set_hl(0, "WinBar", { link = "Normal" })
            vim.api.nvim_set_hl(0, "WinBarNC", { link = "Normal" })
          end
        '';
      }
    ];
  };
}
