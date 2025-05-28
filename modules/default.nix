{...}: {
  imports = [
    ./bootloader.nix
    ./nixos.nix
    ./user.nix
    ./networking.nix
    ./locale.nix
  ];
}
