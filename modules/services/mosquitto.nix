{
  lib,
  config,
  ...
}: let
  cfg = config.settings.services.mosquitto;
in {
  options.settings.services.mosquitto = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    services.mosquitto = {
      enable = true;
      listeners = [
        {
          acl = ["pattern readwrite #"];
          omitPasswordAuth = true;
          settings.allow_anonymous = true;
        }
      ];
    };
    networking.firewall.allowedTCPPorts = [1883];
  };
}
