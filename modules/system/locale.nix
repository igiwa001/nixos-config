{
  lib,
  config,
  ...
}: {
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
    time.timeZone = config.settings.locale.timeZone;
    console.keyMap = config.settings.locale.keymap;
    services.xserver.xkb.layout = config.settings.locale.keymap;
  };
}
