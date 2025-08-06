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

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    my-lib = import ./lib {inherit (nixpkgs) lib;};
    overlays = my-lib.overlays.importOverlays ./overlays;
    overlayModule = {nixpkgs.overlays = overlays;};
  in {
    # NixOS configuration
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs my-lib;};
        modules = [
          ./hosts/thinkpad/configuration.nix
          overlayModule
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs my-lib;};
        modules = [
          ./hosts/desktop/configuration.nix
          overlayModule
        ];
      };
    };

    legacyPackages = my-lib.forAllSystems (system: import nixpkgs {inherit system overlays;});
  };
}
