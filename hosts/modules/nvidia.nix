{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
  };
}
