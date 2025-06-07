{
  lib,
  config,
  ...
}: {
  options.settings.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.settings.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
