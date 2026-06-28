{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    withRuby = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      lua-language-server
      python311Packages.python-lsp-server
      nixd
      vimPlugins.nvim-treesitter-parsers.hyprlang
    ];
  };
}
