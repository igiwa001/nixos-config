{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # NixOS-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NVF
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    inherit (nixpkgs) lib;
    my-lib = import ./lib {inherit lib;};
    overlays = import ./overlays;
    sharedModules = [./modules {nixpkgs.overlays = overlays;}];
  in {
    # NixOS configuration
    nixosConfigurations = {
      thinkpad = lib.nixosSystem {
        specialArgs = {inherit inputs my-lib;};
        modules = sharedModules ++ [./hosts/thinkpad/configuration.nix];
      };
      desktop = lib.nixosSystem {
        specialArgs = {inherit inputs my-lib;};
        modules = sharedModules ++ [./hosts/desktop/configuration.nix];
      };
    };

    # Nixpkgs instance
    legacyPackages = my-lib.forAllSystems (system:
      import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      });
  };
}
