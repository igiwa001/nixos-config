{
  lib,
  config,
  ...
}: let
  cfg = config.settings.hardware.razer-nari;
in {
  options.settings.hardware.razer-nari.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config.services.pipewire.wireplumber.extraConfig = lib.mkIf cfg.enable {
    razer-nari-pro-audio."monitor.alsa.rules" = [
      {
        matches = [{"device.name" = "~alsa_card.usb-Razer_Razer_Nari_Ultimate-*";}];
        actions.update-props."device.profile" = "pro-audio";
      }
    ];
  };
}
