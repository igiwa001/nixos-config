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
}
