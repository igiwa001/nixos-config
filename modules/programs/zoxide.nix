{
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.zoxide;
in {
  options.settings.programs.zoxide.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.programs.zoxide = lib.mkIf cfg.enable {
    enable = true;
    options = ["--cmd cd"];
  };
}
