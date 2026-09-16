{
  lib,
  config,
  ...
}: let
  cfg = config.settings.defaults;
in {
  options.settings.defaults = {
    terminal = lib.mkOption {
      type = with lib.types; nullOr str;
      default = "kitty";
    };

    browser = lib.mkOption {
      type = with lib.types; nullOr str;
      default = "firefox";
    };
  };

  config.environment.sessionVariables.TERMINAL =
    lib.mkIf (cfg.terminal != null) cfg.terminal;
}
