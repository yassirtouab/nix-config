{ pkgs, ... }: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    # AMD Ryzen 5 PRO 5650U integrated graphics uses gfx90c (Vega)
    rocmOverrideGfx = "9.0.0";
  };

  services.open-webui = {
    enable = true;
  };
}
