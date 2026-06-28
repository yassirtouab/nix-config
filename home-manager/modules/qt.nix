{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    papirus-icon-theme
    pcmanfm-qt
  ];
  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "gtk";
    style = {
      package = lib.mkForce pkgs.adwaita-qt;
      name = lib.mkForce "adwaita-dark";
    };
  };
}
