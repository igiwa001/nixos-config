{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.services.factorio;
in {
  options.settings.services.factorio = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    version = lib.mkOption {
      type = lib.types.str;
      default = "2.0.77";
    };
  };

  config.services.factorio = lib.mkIf cfg.enable {
    enable = true;
    openFirewall = true;
    nonBlockingSaving = true;
    loadLatestSave = true;

    package = pkgs.factorio-headless.overrideAttrs {
      inherit (cfg) version;
      name = "factorio-headless-${cfg.version}";
      src = pkgs.fetchurl {
        name = "factorio_headless_x64-${cfg.version}.tar.xz";
        url = "https://factorio.com/get-download/${cfg.version}/headless/linux64";
        sha256 = "sha256-xO/BFSn3TTfJaTPikeDbc/2fWqRziRPZMBskaAs+lH8=";
      };
    };
  };
}
