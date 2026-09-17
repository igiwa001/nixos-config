{
  self,
  inputs,
  ...
}: let
  inherit
    (inputs.nixos-hardware.nixosModules)
    common-pc
    common-cpu-intel-cpu-only
    ;
in {
  den.hosts.x86_64-linux.server.users.igorai = {};

  den.aspects.server.nixos = {
    imports = [
      ./_hardware.nix
      "${self.outPath}/legacy/hosts/server/fancontrol.nix" # Legacy
      common-pc
      common-cpu-intel-cpu-only
    ];

    # Legacy
    settings = {
      system.stateVersion = "25.05";
      networking.hostname = "server";
      nixos.cores = 4;
      bootloader = {
        loader = "grub";
        grub.device = "/dev/sda";
      };
      services.sshd.enable = true;

      hyprland.enable = false;
      programs = {
        discord.enable = false;
        firefox.enable = false;
        kitty.enable = false;
        libreoffice.enable = false;
        noisetorch.enable = false;
        sddm.enable = false;
        slack.enable = false;
        spotify.enable = false;
        steam.enable = false;
        bottles.enable = false;
      };
    };
  };
}
