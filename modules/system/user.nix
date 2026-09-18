{
  den,
  lib,
  lib',
  ...
}: let
  user = lib'.makeOverridableAspect ({shell ? "bash"}: {
    name = "user";
    description = ''
      Defines and configures a user.
      The user shell is set to bash by default, but can be overridden.

      Usage:
        den.aspects.example.includes = [den.aspects.user];
        den.aspects.example.includes = [(den.aspects.user.override { shell = "zsh"; })];
    '';

    includes = [
      den.batteries.define-user
      (den.batteries.user-shell shell)
    ];

    user = {userGroups, ...}: {
      linger = lib.mkDefault false;
      extraGroups = ["video"] ++ userGroups;
      initialPassword = lib.mkDefault "password";
    };
  });

  admin = lib'.makeOverridableAspect (params: {
    name = "user/admin";
    description = ''
      Defines and configures an admin user.
      Exposes the same override options as `den.aspects.system.user`.
    '';

    includes = [
      (user.override params)
      den.batteries.primary-user
    ];

    user = {adminGroups, ...}: {
      extraGroups = adminGroups;
      linger = true;
    };
  });
in {
  den.aspects.system = {
    inherit user admin;
  };

  den.quirks = {
    userGroups.description = ''
      User groups to be added to all users.
    '';
    adminGroups.description = ''
      User groups to be added to admin users.
    '';
  };
}
