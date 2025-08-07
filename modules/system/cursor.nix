{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.cursor;
in {
  options.settings.cursor = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = "Notwaita-Black";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.notwaita-cursor;
    };

    size = lib.mkOption {
      type = lib.types.ints.positive;
      default = 22;
    };
  };

  config.settings.home-manager.home.pointerCursor = lib.mkIf cfg.enable {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor = {
      enable = true;
      inherit (cfg) size;
    };
    inherit (cfg) name;
    inherit (cfg) package;
    inherit (cfg) size;
  };
}
