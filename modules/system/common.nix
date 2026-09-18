{lib, ...}: let
  description = ''
    Common miscellaneous system settings that didn't fit anywhere else.
    Includes some common packages and sets the kernel version.
  '';

  packages = let
    description = ''
      Includes common packages/programs.
    '';

    getPackages = pkgs:
      with pkgs; [
        vim
        curl
        zip
        unzip
        screen
        nix-output-monitor
      ];
  in {
    name = "common/packages";
    inherit description;

    nixos = {pkgs, ...}: {
      environment.systemPackages = getPackages pkgs;
    };

    homeManager = {pkgs, ...}: {
      home.packages = getPackages pkgs;
    };
  };

  kernel = {
    name = "common/kernel";
    description = ''
      Sets the latest available kernel as default.
    '';

    nixos = {pkgs, ...}: {
      boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    };
  };
in {
  den.aspects.system.common = {
    name = "common";
    inherit description;
    includes = [
      packages
      kernel
    ];
  };
}
