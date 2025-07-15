{lib, ...} @ params: {
  types = import ./types.nix params;
  overlays = import ./overlays.nix params;

  forAllSystems = lib.genAttrs lib.systems.flakeExposed;
}
