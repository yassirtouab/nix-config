{ inputs, pkgs, ... }: {
  imports = [
    # Import flake modules for home-manager
    inputs.noctalia.homeModules.default
  ];

  # Enable user-level compositor settings
  programs.niri.enable = true;
  programs.noctalia.enable = true;

  # Configure Noctalia desktop variables, theme, and wallpaper
  programs.noctalia.settings = {
    theme = {
      mode = "dark";
      source = "builtin";
      builtin = "Catppuccin";
    };
    wallpaper = {
      enabled = true;
      default.path = "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/DenverCoder1/minimalistic-wallpaper-collection/main/images/olly-moss-firewatch-blue-forest.png";
        sha256 = "e2045f655091b013fdb089e43ca9ee8d4c53f5af94e7c98fa769b04ecd585a4c";
      }}";
    };
  };

  # Link custom Niri config file from our configuration repository
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
}
