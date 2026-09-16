{lib, ...} @ params: {
  types = import ./types.nix params;

  forAllSystems = lib.genAttrs lib.systems.flakeExposed;
}
