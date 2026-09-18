{
  inputs,
  self,
  lib,
  ...
}: let
  my-lib = import ../legacy/lib {inherit lib;};
  overlays = import ../legacy/overlays;

  # Overwrite lib.nixosSystem specialArgs
  instantiate = args @ {specialArgs ? {}, ...}:
    lib.nixosSystem (args // {specialArgs = specialArgs // {inherit inputs self my-lib;};});

  compatModule = {host, ...}: {
    nixos = {config, ...}: let
      cfg = config.settings;
    in {
      options.settings.home-manager = lib.mkOption {
        description = "Legacy home-manager settings aggregator";
        type = my-lib.types.mergeableAnything;
        default = {};
      };

      imports = [
        "${self.outPath}/legacy/hosts/${host.name}/configuration.nix" # Import legacy configuration.nix
        "${self.outPath}/legacy/modules" # Import legacy modules
      ];

      config = {
        nixpkgs = {inherit overlays;}; # Apply legacy overlays
        home-manager.users.${cfg.user.username} = cfg.home-manager; # Apply legacy home-manager settings
      };
    };
  };
in {
  den = {
    schema.host.includes = [compatModule];

    hosts.x86_64-linux = {
      thinkpad = {inherit instantiate;};
      desktop = {inherit instantiate;};
      server = {inherit instantiate;};
    };
  };

  perSystem = {system, ...}: {
    legacyPackages = import inputs.nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
  };
}
