{ homeStateVersion, user, inputs, ... }: {
  imports = [
    ./modules
    ./home-packages.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        zen-browser = inputs.zen-browser.packages.${final.stdenv.hostPlatform.system}.default;
      })
    ];
  };

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
}
