{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.lact];
  systemd = {
    packages = [pkgs.lact];
    services.lactd = {
      enable = true;
      after = ["multi-user.target"];
      wantedBy = ["multi-user.target"];
    };
  };
}
