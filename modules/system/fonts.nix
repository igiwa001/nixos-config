{
  lib,
  config,
  pkgs,
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

    installedFonts = lib.mkOption {
      type = with lib.types; listOf str;
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

      packages = [
        (pkgs.nerdfonts.override
          {
            fonts =
              ["DejaVuSansMono"]
              ++ config.settings.fonts.installedFonts;
          })
      ];
    };
  };
}
