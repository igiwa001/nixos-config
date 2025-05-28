{
  lib,
  config,
  ...
}: {
  options.locale = {
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Oslo";
    };

    language = lib.mkOption {
      type = lib.types.str;
      default = "no";
    };
  };

  config = {
    time.timeZone = config.locale.timeZone;
    console.keyMap = config.locale.language;
    services.xserver.xkb.layout = config.locale.language;
  };
}
