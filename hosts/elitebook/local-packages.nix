{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Add local host-specific packages here
  ];
}
