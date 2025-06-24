{lib, ...}: {
  options.settings.defaults = {
    terminal = lib.mkOption {
      type = with lib.types; nullOr str;
      default = "kitty";
    };

    browser = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
    };
  };
}
