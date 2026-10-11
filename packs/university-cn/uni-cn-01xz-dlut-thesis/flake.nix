{
  description = "dlut-thesis";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        deps = with pkgs; [
          texlive.combined.scheme-full
        ];
      in
      {
        devShells.default = pkgs.mkShell { buildInputs = deps; };
      }
    );
}
