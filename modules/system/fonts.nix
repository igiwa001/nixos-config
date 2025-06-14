{
  lib,
  config,
  ...
}: {
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

  config = {
    fonts = {
      enableDefaultPackages = config.settings.fonts.defaultFonts;
      fontconfig = {
        enable = true;
        hinting.enable = config.settings.fonts.hinting;
      };

      packages = config.settings.fonts.packages;
    };
  };
}
