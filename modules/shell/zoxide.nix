{
  lib,
  config,
  ...
}: let
  cfg = config.settings.shell.zoxide;
in {
  options.settings.shell.zoxide.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.programs.zoxide = lib.mkIf cfg.enable {
    enable = true;
    options = ["--cmd cd"];
  };
}
