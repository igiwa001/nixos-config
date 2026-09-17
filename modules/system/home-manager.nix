{lib, ...}: {
  den.aspects.system.home-manager = {
    name = "home-manager";
    description = ''
      Enables home-manager and sets common home-manager settings.
      Infers a default value for home-manager stateVersion from it's nixos host.
    '';

    nixos.home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };

    homeManager = {osConfig, ...}: {
      programs.home-manager.enable = true;
      home.stateVersion = lib.mkDefault osConfig.system.stateVersion;
    };
  };

  # Enable home-manager for all users by default.
  den.schema.user.classes = lib.mkDefault ["homeManager"];
}
