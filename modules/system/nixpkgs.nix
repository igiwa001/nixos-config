{
  lib,
  inputs,
  self,
  ...
}: let
  description = ''
    Sets common nixpkgs settings and adds the current flake into the nix registry as 'pkgs' across both nixos and homeManager.
  '';

  # Nixpkgs configuration
  config = {
    allowUnfree = true;
  };

  nixpkgs-config = {
    name = "nixpkgs/config";
    description = ''
      Sets some common nixpkgs settings.
    '';

    nixos.nixpkgs = {inherit config;};
    homeManager = {osConfig, ...}: {
      nixpkgs =
        lib.mkIf
        (!osConfig.home-manager.useGlobalPkgs)
        {inherit config;};
    };
  };

  nixpkgs-registry = let
    description = ''
      Adds this flake into the nix registry as 'pkgs'.
    '';

    nix.registry.pkgs = {
      from = {
        type = "indirect";
        id = "pkgs";
      };
      to = {
        type = "path";
        path = self.outPath;
      };
    };
  in {
    name = "nixpkgs/registry";
    inherit description;

    nixos = {inherit nix;};
    homeManager = {inherit nix;};
  };
in {
  den.aspects.system.nixpkgs = {
    name = "nixpkgs";
    inherit description;
    includes = [
      nixpkgs-config
      nixpkgs-registry
    ];
  };

  # Re-export nixpkgs with custom config
  perSystem = {system, ...}: {
    legacyPackages =
      import inputs.nixpkgs
      {inherit system config;};
  };
}
