{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # General NixOS settings
  nix = {
    channel.enable = lib.mkDefault false;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = lib.mkDefault true;
    };
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 1w";
    };
  };
  nixpkgs.config.allowUnfree = lib.mkDefault true;
  documentation.nixos.enable = lib.mkDefault false;

  # Common packages and binaries
  environment.systemPackages = with pkgs; [
    wget
    zip
  ];
}
