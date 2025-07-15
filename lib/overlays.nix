{...}: {
  importOverlays = path: let
    getOverlay = value:
      {
        lambda = overlay: [overlay];
        set = {
          overlay ? null,
          imports ? [],
        }:
          builtins.foldl' (overlays: path: overlays ++ getOverlay (import path)) (
            if overlay == null
            then []
            else [overlay]
          )
          imports;
      }.${
        builtins.typeOf value
      }
      value;
  in
    getOverlay (import path);
}
