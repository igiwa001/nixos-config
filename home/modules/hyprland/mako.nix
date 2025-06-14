{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.mako = {
    enable = true;
    settings.default-timeout = 3000;
  };
}
