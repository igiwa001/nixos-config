{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.libreoffice;
in {
  options.settings.programs.libreoffice.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf cfg.enable {
    settings.home-manager.home.packages = [pkgs.libreoffice];
    environment.systemPackages = [
      pkgs.hunspell
      pkgs.hunspellDicts.en_US-large
      pkgs.hunspellDicts.pl_PL
      pkgs.hunspellDicts.nb_NO
    ];
  };
}
