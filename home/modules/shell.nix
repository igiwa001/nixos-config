{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.bash.enable = true;
  programs.eza.enable = true;
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
  programs.htop.enable = true;
  home.packages = [pkgs.screen];
}
