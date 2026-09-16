{
  lib,
  config,
  ...
}: let
  cfg = config.settings.locale;
in {
  options.settings.locale = {
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Oslo";
    };

    keymap = lib.mkOption {
      type = lib.types.str;
      default = "no";
    };
  };

  config = {
    time.timeZone = cfg.timeZone;
    console.keyMap = cfg.keymap;
    services.xserver.xkb.layout = cfg.keymap;
  };
}
