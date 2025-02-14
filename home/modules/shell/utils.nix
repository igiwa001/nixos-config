{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.eza.enable = true;
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
  programs.htop.enable = true;
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/.dotfiles";
  };
  home.packages = [
    pkgs.screen
    pkgs.nix-output-monitor
    pkgs.google-cloud-sdk
    pkgs.pnpm
    pkgs.nodejs_22
  ];
}
