{pkgs, ...}: {
  settings.services.minecraft = {
    enable = true;
    servers.fabric = {
      enable = true;
      autoStart = true;
      package = pkgs.minecraftServers.fabric-1_21_9;
      jvmOpts = "-Xms4G -Xmx6G";

      serverProperties = {
        difficulty = "hard";
        spawn-protection = 0;
        view-distance = 32;
      };

      symlinks.mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
        Servux = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/zQhsx8KF/versions/1aOMm00f/servux-fabric-1.21.10-rc1-0.8.1.jar";
          sha512 = "a78fbdc85d16d433d3e573ca72f35fe99d8cc3c952406d9e7e25a30431e1026ecbbd11f9a507b2515668790881e354e346a48601073cc93398eceb285eb4dfd9";
        };
      });
    };
  };
}
