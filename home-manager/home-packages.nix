{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    anytype
    brave
    ghostty
    localsend
    mpv
    onlyoffice-desktopeditors
    pavucontrol
    signal-desktop
    telegram-desktop
    zapzap
    zen-browser

    # CLI utils
    bc
    brightnessctl
    btop
    cliphist
    ffmpeg
    ffmpegthumbnailer
    fzf
    git-graph
    grimblast
    htop
    hyprpicker
    jq
    ntfs3g
    mediainfo
    microfetch
    playerctl
    ripgrep
    udisks
    ueberzugpp
    unzip
    w3m
    wget
    wl-clipboard
    wtype
    yazi
    yt-dlp
    zip

    # Coding stuff
    bun
    nodejs
    openjdk23
    python311
    uv
    vscode

    # WM stuff
    hyprpolkitagent
    libsForQt5.xwaylandvideobridge
    libnotify
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # Other
    bemoji
    nix-prefetch-scripts
  ];
}
