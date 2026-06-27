{ inputs, user, ... }: {
  imports = [ inputs.home-manager.nixosModules.default ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs user;
      homeStateVersion = "24.11";
    };
    users.${user} = import ../../home-manager/home.nix;
  };
}
