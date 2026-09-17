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

  legacyModules.nixos = {
    imports = [../legacy/modules];
    nixpkgs = {inherit overlays;};
  };

  homeManagerCompatModule.nixos = {config, ...}: let
    cfg = config.settings;
  in {
    options.settings.home-manager = lib.mkOption {
      type = my-lib.types.mergeableAnything;
      default = {};
    };

    config.home-manager.users.${cfg.user.username} = cfg.home-manager;
  };
in {
  den = {
    hosts.x86_64-linux = {
      thinkpad = {inherit instantiate;};
      desktop = {inherit instantiate;};
      server = {inherit instantiate;};
    };

    default.includes = [legacyModules];
    schema.host.includes = [homeManagerCompatModule];
  };

  perSystem = {system, ...}: {
    legacyPackages = import inputs.nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
  };
}
