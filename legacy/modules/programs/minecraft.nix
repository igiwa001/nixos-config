{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.minecraft;
in {
  options.settings.programs.minecraft.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.prismlauncher];
  };
}
