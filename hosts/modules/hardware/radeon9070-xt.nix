{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xffffffff"];
  systemd.services.radeon9070-xt = {
    enable = true;
    wantedBy = ["multi-user.target"];
    after = ["multi-user.target"];
    path = [pkgs.bash];

    serviceConfig = {
      ExecStart = ./radeon9070-xt;
      Type = "idle";
    };
  };
}
