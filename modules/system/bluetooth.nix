{lib', ...}: let
  description = ''
    Enables bluetooth capabilities and blueman, a GUI bluetooth manager.
    By default bluetooth is powered off on boot, but this can be overridden.

    Usage:
      den.aspects.example.includes = [den.aspects.bluetooth];
      den.aspects.example.includes = [(den.aspects.bluetooth.override { powerOnBoot = true; })];
  '';

  bluetooth = lib'.makeOverridableAspectWith ({powerOnBoot ? false}: {
    name = "bluetooth/enable";
    description = ''
      Enables hardware bluetooth capabilities.
      Optionally powers on the bluetooth device on boot.
    '';

    nixos.hardware.bluetooth = {
      enable = true;
      inherit powerOnBoot;
    };
  });

  blueman = {
    name = "bluetooth/blueman";
    description = ''
      Enables blueman, a GUI bluetooth manager.
      Additionally prevents it from starting on boot.
    '';

    nixos.services.blueman.enable = true;

    # Prevent blueman from starting on boot.
    homeManager.xdg.configFile."autostart/blueman.desktop".text = ''
      [Desktop Entry]
      Hidden=true
    '';
  };
in {
  den.aspects.system.bluetooth = lib'.makeOverridableAspect (params: {
    name = "bluetooth";
    inherit description;
    includes = [
      (bluetooth params)
      blueman
    ];
  });
}
