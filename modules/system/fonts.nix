{
  lib,
  config,
  ...
}: let
  cfg = config.settings.fonts;
in {
  options.settings.fonts = {
    defaultFonts = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    hinting = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    packages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [];
    };
  };

  config.fonts = {
    inherit (cfg) packages;
    enableDefaultPackages = cfg.defaultFonts;
    fontconfig = {
      enable = true;
      hinting.enable = cfg.hinting;
    };
  };
}
