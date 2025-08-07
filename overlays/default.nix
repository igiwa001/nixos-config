let
  collectOverlays = value:
    {
      lambda = overlay: [overlay];
      set = {
        overlay ? null,
        imports ? [],
      }:
        builtins.foldl' (overlays: path: overlays ++ collectOverlays (import path)) (
          if overlay == null
          then []
          else [overlay]
        )
        imports;
    }.${
      builtins.typeOf value
    }
    value;

  importOverlays = imports: collectOverlays {inherit imports;};
in
  importOverlays
  [./notwaita-cursor.nix]
