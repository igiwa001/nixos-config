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
  home.packages = [pkgs.screen];
}
