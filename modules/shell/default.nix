{pkgs, ...}: {
  imports = [
    ./git.nix
    ./bash.nix
    ./eza.nix
    ./nh.nix
    ./zoxide.nix
  ];

  settings.home-manager.home.packages = [
    pkgs.google-cloud-sdk
    pkgs.pnpm
    pkgs.nodejs_22
  ];
}
