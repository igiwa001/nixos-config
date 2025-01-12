{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Igor Iwanicki";
    userEmail = "igor.iwanicki@protonmail.com";
    extraConfig.credential.helper = "libsecret";
  };

  # Lazygit
  programs.lazygit.enable = true;
  home.shellAliases.lgit = "lazygit";
}
