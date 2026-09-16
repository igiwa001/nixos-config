{
  inputs,
  den,
  ...
}: {
  imports = [
    inputs.den.flakeModule
    inputs.wrappers.flakeModules.wrappers
  ];

  den.default.includes = [
    den.batteries.self'
    den.batteries.inputs'
    den.batteries.host-aspects
    den.batteries.hostname
  ];
}
