{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };



    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    # COMING SOON...
    #nixvim = {
    #  url = "github:nix-community/nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    homeStateVersion = "26.05";
    user = "mugen";
    hosts = [
      { hostname = "elitebook"; stateVersion = "26.05"; }
    ];

    overlays = [
      (final: prev: {
        zen-browser = inputs.zen-browser.packages.${system}.default;
        hyprland = prev.hyprland.overrideAttrs (oldAttrs: {
          postInstall = (oldAttrs.postInstall or "") + ''
            if [ -f "$out/share/wayland-sessions/hyprland.desktop" ]; then
              echo "NoDisplay=true" >> "$out/share/wayland-sessions/hyprland.desktop"
            fi
          '';
        });
      })
    ];

    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs stateVersion hostname user;
      };

      modules = [
        { nixpkgs.hostPlatform = system; }
        inputs.noctalia.nixosModules.default
        inputs.disko.nixosModules.disko
        ./hosts/${hostname}/disko.nix
        ./hosts/${hostname}/configuration.nix
        {
          nixpkgs.overlays = overlays;
        }
      ];
    };

  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {} hosts;

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays;
      };
      extraSpecialArgs = {
        inherit inputs homeStateVersion user;
      };

      modules = [
        ./home-manager/home.nix
      ];
    };
  };
}
