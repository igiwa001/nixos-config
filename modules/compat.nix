{
  inputs,
  self,
  lib,
  ...
}: let
  my-lib = import ../legacy/lib {inherit lib;};
  overlays = (import ../legacy/overlays) ++ [inputs.nix-minecraft.overlay];

  # Overwrite lib.nixosSystem specialArgs
  instantiate = args @ {specialArgs ? {}, ...}:
    lib.nixosSystem (args // {specialArgs = specialArgs // {inherit inputs self my-lib;};});
in {
  den = {
    hosts.x86_64-linux = {
      thinkpad = {inherit instantiate;};
      desktop = {inherit instantiate;};
      server = {inherit instantiate;};
    };

    default.includes = [
      {
        nixos.imports = [../legacy/modules];
        nixos.nixpkgs = {inherit overlays;};
      }
    ];
  };

  perSystem = {system, ...}: {
    legacyPackages = import inputs.nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
  };
}
