{
  lib,
  config,
  ...
}: let
  cfg = config.settings.bluetooth;
in {
  options.settings.bluetooth = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    powerOnBoot = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      inherit (cfg) powerOnBoot;
    };
    services.blueman.enable = true;

    # Disable blueman on boot
    settings.home-manager.xdg.configFile."autostart/blueman.desktop".text = ''
      [Desktop Entry]
      Hidden=true
    '';
  };
}
