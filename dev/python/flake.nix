{
  inputs = { 
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
    nixvim.url = github:pta2002/nixvim;
  };

  outputs = { self, nixpkgs, flake-utils, nixvim }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        vim = nixvim.legacyPackages.${system};
      in rec {
        packages = {
          nvim = vim.makeNixvim {
            colorschemes.gruvbox.enable = true;
            plugins.lightline.enable = true;
          };
          default = packages.nvim;

      };
    });
}
