{pkgs, ...}: {
  imports = [
    ./sddm.nix
    ./kitty.nix
    ./firefox.nix
    ./discord.nix
    ./spotify.nix
    ./noisetorch.nix
    ./steam.nix
    ./slack.nix
    ./adb.nix
    ./lact.nix
    ./libreoffice.nix
    ./git.nix
    ./eza.nix
    ./nh.nix
    ./zoxide.nix
    ./btop.nix
    ./podman.nix
    ./minecraft.nix
    ./teams.nix
  ];

  settings.home-manager.home.packages = [
    pkgs.google-cloud-sdk
    pkgs.pnpm
    pkgs.nodejs_22
  ];
}
