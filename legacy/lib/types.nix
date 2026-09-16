{lib, ...}: let
  # A copy of lib.types.anything that merges list instead of overwriting them.
  mergeableAnything = with lib;
  with types;
    anything
    // {
      merge = loc: defs: let
        getType = value:
          if isAttrs value && isStringLike value
          then "stringCoercibleSet"
          else builtins.typeOf value;

        # Returns the common type of all definitions, throws an error if they
        # don't have the same type
        commonType =
          foldl' (
            type: def:
              if getType def.value == type
              then type
              else throw "The option `${showOption loc}' has conflicting option types in ${showFiles (getFiles defs)}"
          ) (getType (head defs).value)
          defs;

        mergeFunction =
          {
            # Recursively merge attribute sets
            set = (attrsOf mergeableAnything).merge;
            # Recursively merge lists
            list = (listOf mergeableAnything).merge;
            # This is the type of packages, only accept a single definition
            stringCoercibleSet = mergeOneOption;
            lambda = loc: defs: arg:
              mergeableAnything.merge (loc ++ ["<function body>"]) (
                map (def: {
                  inherit (def) file;
                  value = def.value arg;
                })
                defs
              );
            # Otherwise fall back to only allowing all equal definitions
          }
              .${
            commonType
          } or mergeEqualOption;
      in
        mergeFunction loc defs;
    };
in {
  inherit mergeableAnything;

  hostName = lib.types.strMatching "^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$";
}
