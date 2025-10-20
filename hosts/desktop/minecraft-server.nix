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
        FerriteCore = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
          sha512 = "131b82d1d366f0966435bfcb38c362d604d68ecf30c106d31a6261bfc868ca3a82425bb3faebaa2e5ea17d8eed5c92843810eb2df4790f2f8b1e6c1bdc9b7745";
        };
        Krypton = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
          sha512 = "4dcd7228d1890ddfc78c99ff284b45f9cf40aae77ef6359308e26d06fa0d938365255696af4cc12d524c46c4886cdcd19268c165a2bf0a2835202fe857da5cab";
        };
        Lithium = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/L1sSIxFm/lithium-fabric-0.19.2%2Bmc1.21.9.jar";
          sha512 = "ecbebb18f82e589c1d24056b6cfe6a923acb8fea5dd038ed931568db7dc8dad1cfe4b42f9c0f7752ba45f39d4f0cab219deb61fcb54bcc7252c9fe34afc2549a";
        };
        ScalableLux = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PV9KcrYQ/ScalableLux-0.1.6%2Bfabric.c25518a-all.jar";
          sha512 = "729515c1e75cf8d9cd704f12b3487ddb9664cf9928e7b85b12289c8fbbc7ed82d0211e1851375cbd5b385820b4fedbc3f617038fff5e30b302047b0937042ae7";
        };
        VMP = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/wnEe9KBa/versions/ppncuwIK/vmp-fabric-mc1.21.10-0.2.0%2Bbeta.7.215-all.jar";
          sha512 = "4c8026c7a2ee1cfd6b4113565543f87874e5da755640123561371f7ef0bf8d86e0ea4aadd5f96ee527b3903db5b3f01c00cb8052f72e802cee2dd4f32830df59";
        };
      });
    };
  };
}
