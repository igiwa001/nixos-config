{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    initExtra = "[[ -f ~/.profile ]] && . ~/.profile";
  };
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
  ];
}
