{
  lib,
  config,
  ...
}: let
  cfg = config.settings.services.minecraft;
in {
  options.settings.services.minecraft = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    jvmOpts = lib.mkOption {
      type = lib.types.separatedString " ";
      default = "-Xmx6G -Xms6G";
    };

    serverProperties = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [bool int str]);
      default = {
        difficulty = "hard";
        spawn-protection = 0;
        enable-rcon = true;
        "rcon.password" = "password";
      };
    };
  };

  config.services.minecraft-server = lib.mkIf cfg.enable {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = cfg.serverProperties != {};
    inherit (cfg) jvmOpts serverProperties;
  };
}
