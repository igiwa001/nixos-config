(_: prev: {
  vimPlugins = prev.vimPlugins.extend (_: _: {
    oz-nvim = prev.vimUtils.buildVimPlugin {
      pname = "oz.nvim";
      version = "v0.0.4";
      src = prev.fetchFromGitHub {
        owner = "luxluth";
        repo = "oz.nvim";
        rev = "c9a1dc7f4f5cadf6acbddd44b7be243b0140e585";
        hash = "sha256-HO/jVDsDgkTsAQn0KCVc+vGAYbytb0xQGVhks7lmVyI=";
      };
    };
  });
})
