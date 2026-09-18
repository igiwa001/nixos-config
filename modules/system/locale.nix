{lib', ...}: {
  den.aspects.system.locale = lib'.makeOverridableAspect ({
    locale ? "no",
    timeZone ? "Europe/Oslo",
  }: {
    name = "locale";
    description = ''
      Sets the default locale, timezone and keymap.
    '';

    nixos = {
      time = {inherit timeZone;};
      console.keyMap = locale;
      services.xserver.xkb.layout = locale;
    };
  });
}
