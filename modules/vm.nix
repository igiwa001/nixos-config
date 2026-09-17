# Creates vm derivations for each host across all platforms.
# Use `nix run .#vm-<hostName>` to run a specific host's vm.
{
  self,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: {
    apps =
      lib.concatMapAttrs (name: host: {
        "vm-${name}".program = pkgs.writeShellApplication {
          name = "vm-${name}";
          text = ''
            ${lib.getExe host.config.system.build.vm} \
            -m 4G -smp 4 "$@" &
          '';
        };
      })
      self.nixosConfigurations;
  };
}
