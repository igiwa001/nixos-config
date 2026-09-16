{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.adb;
in {
  options.settings.programs.adb.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg.enable {
    programs.adb.enable = true;
    services.udev.packages = [pkgs.android-udev-rules];
    environment.systemPackages = [pkgs.android-tools];

    programs.nix-ld = {
      enable = true;
      libraries = [pkgs.android-tools];
    };

    settings.user.groups = ["adbusers"];
  };
}
