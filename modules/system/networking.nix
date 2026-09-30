{
  den.aspects.system.networking = {
    name = "networking";
    description = ''
      Enables networking capabilities.
      Automatically adds 'networkmanager' group to all users.
    '';

    # Adds 'networkmanager' group to all users
    userGroups = ["networkmanager"];

    nixos.networking = {
      wireless.iwd.enable = true;
      networkmanager = {
        enable = true;
        wifi = {
          powersave = false;
          backend = "iwd";
        };
      };
    };
  };
}
