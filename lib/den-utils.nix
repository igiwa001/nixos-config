let
  # Makes an aspect overridable by calling its `override` function with the new inputs.
  # Accepts a function which takes an attribute set and returns an aspect, and a default value for the function parameter.
  # Overridable aspects can be overridden multiple times.
  # When overriding, the new parameter will be merged with the previous.
  makeOverridableAspectWith = f: prev: {
    name = "<anon>"; # Prevent deduplication
    includes = [(f prev)];
    override = next: makeOverridableAspectWith f (prev // next);
  };

  # `makeOverridableAspectWith` with the default parameter set to `{}`.
  makeOverridableAspect = f: makeOverridableAspectWith f {};
in {
  inherit
    makeOverridableAspectWith
    makeOverridableAspect
    ;
}
