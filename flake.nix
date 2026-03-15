{
    description = "Gymnasium + ALE dev environment";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    outputs = { self, nixpkgs }:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };

            python = pkgs.python313;

            pythonEnv = python.withPackages (ps: with ps; [
                gymnasium
                ale-py
                torch
            ]);

        in {
            devShells.${system}.default = pkgs.mkShell {
                packages = [
                    pythonEnv
                ];
                shellHook = ''
                    export LD_LIBRARY_PATH=${pkgs.SDL2}/lib:$LD_LIBRARY_PATH
                    export ALE_ROMS_DIR=$PWD/roms
                    exec zsh
                '';
            };
        };
}

