{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    openssh.enable = true;
    fail2ban = {
      enable = true;
      bantime-increment.enable = true;
      bantime = "1h";
    };
  };
}
