{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hyprland.mako;
in {
  options.settings.hyprland.mako = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.settings.hyprland.enable;
    };

    max-history = lib.mkOption {
      type = with lib.types; addCheck int (x: x >= 0);
      default = 10;
    };

    max-visible = lib.mkOption {
      type = with lib.types; addCheck int (x: x >= -1);
      default = 10;
    };

    default-timeout = lib.mkOption {
      type = with lib.types; addCheck int (x: x >= 0);
      default = 5000;
    };
  };

  config.settings = lib.mkIf cfg.enable {
    home-manager.services.mako = {
      enable = true;
      settings = {
        max-history = cfg.max-history;
        max-visible = cfg.max-visible;
        default-timeout = cfg.default-timeout;

        font = "FiraMono Nerd Font 11";
        background-color = "#24273acc";
        text-color = "#cad3f5";
        border-color = "#494d64";
        border-radius = 8;
        icon-border-radius = 6;
        padding = "8,0";
        margin = 4;
        layer = "overlay";
        anchor = "top-center";
      };
    };

    fonts.packages = [pkgs.nerd-fonts.fira-mono];
  };
}
