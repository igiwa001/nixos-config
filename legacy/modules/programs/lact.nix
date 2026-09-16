{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.lact;
in {
  options.settings.programs.lact.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.lact];
    systemd = {
      packages = [pkgs.lact];
      services.lactd = {
        enable = true;
        after = ["multi-user.target"];
        wantedBy = ["multi-user.target"];
      };
    };
  };
}
