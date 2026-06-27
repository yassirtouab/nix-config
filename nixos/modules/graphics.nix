{ pkgs, ... }: {
  # Enable Mesa / OpenGL graphics driver stack
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  # Early KMS loading for AMD GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
}
