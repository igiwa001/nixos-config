# The library is built upon a custom implementation of a module system.
# This file is the entrypoint and includes all the utilities required to bootstrap the rest of the library.
# A library module must be either an attribute set or a unary function that return an attribute set.
# The function parameter includes self (the final library attribute set) and any other values passed in externally.
let
  inherit
    (builtins)
    map
    foldl'
    typeOf
    isPath
    hasAttr
    isString
    toString
    mapAttrs
    isFunction
    ;

  # Attempts to imports the passed value if possible,
  # otherwise returns it as is.
  import' = x:
    if isPath x || isString x
    then import x
    else x;

  # If y is a function calls y with x,
  # otherwise returns y.
  apply' = x: y:
    if isFunction y
    then y x
    else y;

  # Pipes a value through a list of functions left to right.
  pipe = foldl' (x: f: f x);

  # Asserts that two values are equal.
  # Returns the first value if true, otherwise throws an error.
  assertEq = x: y: msg:
    assert (x == y)
    || throw "${msg} (${toString x} != ${toString y})"; x;

  # Merges two values throwing an error on conflicting types and values.
  # Attribute sets are merged recursively.
  merge = x: y:
    {
      list = x ++ y;
      set = mapAttrs (n: v:
        if (hasAttr n x) && (hasAttr n y)
        then merge x.${n} y.${n}
        else v) (x // y);
    }.${
      assertEq (typeOf x) (typeOf y) "Conflicting types"
    } or (assertEq x y "Conflicting values");

  # Imports and recursively evaluates a list of modules with the provided arguments.
  # Returns the final merged attribute set.
  # This function is meant to be used to load the rest of the library.
  evalModules = args: modules: let
    self = pipe modules [
      (map import')
      (map (apply' (args // {inherit self;})))
      (foldl' merge {})
    ];
  in
    self;
in {
  inherit
    import'
    apply'
    pipe
    assertEq
    merge
    evalModules
    ;
}
