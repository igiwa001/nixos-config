{
  den.aspects.system.nix = {
    name = "nix";
    description = ''
      Sets common default nix settings.
      Disables nix channels, enables nix flakes and automatic weekly nix-store optimisation and garbage collection.
    '';

    nixos.nix = {
      channel.enable = false;
      settings = {
        experimental-features = ["flakes" "nix-command"];
        auto-optimise-store = true;
        trusted-users = ["@wheel"];
      };

      optimise = {
        automatic = true;
        persistent = true;
        dates = "weekly";
      };

      gc = {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
  };
}
