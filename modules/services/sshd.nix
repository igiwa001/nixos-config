{
  lib,
  config,
  ...
}: let
  cfg = config.settings.services.sshd;
in {
  options.settings.services.sshd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
    };
    settings.services.fail2ban.enable = lib.mkDefault true;
  };
}
