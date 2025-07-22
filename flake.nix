{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    my-lib = import ./lib {lib = nixpkgs.lib;};
    overlays = my-lib.overlays.importOverlays ./overlays;
    overlayModule = {nixpkgs.overlays = overlays;};

    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    # NixOS configuration
    nixosConfigurations = {
      thinkpad-e14 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/thinkpad-e14/configuration.nix];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/desktop/configuration.nix];
      };
      thinkpad-modular = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs my-lib;};
        modules = [
          ./hosts/thinkpad-modular/configuration.nix
          overlayModule
        ];
      };
      desktop-modular = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs my-lib;};
        modules = [
          ./hosts/desktop-modular/configuration.nix
          overlayModule
        ];
      };
    };
    # Home-manager configuration
    homeConfigurations = {
      igorai = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/igorai.nix];
      };
      igorai-minimal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/igorai-minimal.nix];
      };
    };

    legacyPackages = my-lib.forAllSystems (system: import nixpkgs {inherit system overlays;});
  };
}
