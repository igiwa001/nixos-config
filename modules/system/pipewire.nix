{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.pipewire;
in {
  options.settings.pipewire.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
    environment.systemPackages = [pkgs.pwvucontrol];
  };
}
