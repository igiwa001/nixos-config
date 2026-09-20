{
  lib,
  config,
  ...
}: let
  cfg = config.settings.services.easyeffects;
in {
  options.settings.services.easyeffects.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;
    settings.home-manager.services.easyeffects = {
      enable = true;
      preset = "noise-suppression";
      extraPresets.noise-suppression.input = {
        blocklist = [];
        plugins_order = ["rnnoise"];
        "rnnoise" = {
          bypass = false;
          enable-vad = true;
          input-gain = 0.0;
          output-gain = 0;
          release = 20.0;
          vad-thres = 60;
          wet = 0;
        };
      };
    };
  };
}
