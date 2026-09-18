let
  description = ''
    Enables pipewire and sets some common settings.
    Additionally enables pwvucontrol and rtkit.
  '';

  pipewire = {
    name = "pipewire/enable";
    description = ''
      Enables pipewire and sets some common settings.
    '';

    nixos.services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  rtkit = {
    name = "pipewire/rtkit";
    description = ''
      Enables rtkit, which enables realtime scheduling for pipewire.
    '';

    nixos.security.rtkit.enable = true;
  };

  pwvucontrol = {
    name = "pipewire/pwvucontrol";
    description = ''
      Enables pwvucontrol for volume control.
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.pwvucontrol];
    };
  };
in {
  den.aspects.system.pipewire = {
    name = "pipewire";
    inherit description;
    includes = [
      pipewire
      rtkit
      pwvucontrol
    ];
  };
}
