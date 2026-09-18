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

  compatModule = {
    host,
    user,
    ...
  }: {
    nixos = {config, ...}: let
      cfg = config.settings;
    in {
      options.settings = {
        home-manager = lib.mkOption {
          description = "Legacy home-manager settings aggregator";
          type = my-lib.types.mergeableAnything;
          default = {};
        };

        user = {
          username = lib.mkOption {
            description = "Re-export legacy username variable";
            type = lib.types.str;
            default = user.userName;
          };
          groups = lib.mkOption {
            description = "Collect legacy extra user groups";
            type = lib.types.listOf lib.types.str;
            default = [];
          };
          homeDirectory = lib.mkOption {
            description = "Re-export legacy home directory variable";
            type = lib.types.str;
            default = "/home/${user.userName}";
          };
        };

        locale.keymap = lib.mkOption {
          description = "Re-export legacy locale/keymap variable";
          type = lib.types.str;
          default = config.console.keyMap;
        };
      };

      imports = [
        "${self.outPath}/legacy/hosts/${host.name}/configuration.nix" # Import legacy configuration.nix
        "${self.outPath}/legacy/modules" # Import legacy modules
      ];

      config = {
        nixpkgs = {inherit overlays;}; # Apply legacy overlays
        users.users.${user.userName}.extraGroups = cfg.user.groups; # Apply legacy user groups
        home-manager.users.${user.userName} = cfg.home-manager; # Apply legacy home-manager settings
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
