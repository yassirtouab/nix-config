{
  environment.sessionVariables = rec {
    TERMINAL = "ghostty";
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
}
