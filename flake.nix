{
  description = "Flake utils demo";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, devshell, flake-utils }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;

      name = "Nebula";

      preOverlays = [
        devshell.overlay # TODO: Shouldn't be included in the end package
      ];

      overlay = final: prev: {
        nebula = { };
      };

      shell = { pkgs ? import <nixpkgs> }:
        with pkgs.devshell;
        mkShell {
          devshell.packages = with pkgs; [
            (texlive.combine { inherit (texlive) scheme-basic latexmk; })
            pandoc
          ];
        };
    };
}
