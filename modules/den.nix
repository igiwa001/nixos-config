{
  inputs,
  den,
  ...
}: {
  imports = [
    inputs.den.flakeModule
    inputs.wrappers.flakeModules.wrappers
  ];

  den.default.includes =
    (with den.batteries; [
      self'
      inputs'
      host-aspects
      hostname
    ])
    ++ (with den.aspects; [
      system.bootloader
      system.bluetooth
      system.common
      system.home-manager
      system.locale
      system.pipewire
    ]);
}
