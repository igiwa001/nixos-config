{
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.eza;
in {
  options.settings.programs.eza.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager = lib.mkIf cfg.enable {
    programs.eza.enable = true;
    home.shellAliases.tree = "eza -T";
  };
}
