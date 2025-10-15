{
    description = "exercism";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs }: {
        devShells.x86_64-linux.default =
            let
                pkgs = nixpkgs.legacyPackages."x86_64-linux";
            in
                pkgs.mkShell {
                    buildInputs = with pkgs; [
                        exercism
                        git
                        gleam
                        erlang_27
                        rebar3
                    ];

                    shellHook = ''
                        exercism configure -w /home/jazzkid/projects/personal/exercism
                    '';
                };
        };
}
