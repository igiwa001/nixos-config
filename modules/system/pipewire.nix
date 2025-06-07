{
  lib,
  config,
  pkgs,
  ...
}: {
  options.settings.system = {
    pipewire = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.settings.system.pipewire {
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
