{ pkgs, user, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      description = "Mugen";
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
  };

  services.getty.autologinUser = user;
}
