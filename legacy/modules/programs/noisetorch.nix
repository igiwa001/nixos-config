{
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.noisetorch;
in {
  options.settings.programs.noisetorch.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.programs.noisetorch.enable = lib.mkIf cfg.enable true;
}
