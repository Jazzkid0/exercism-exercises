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
                        starship
                        exercism
                        git
                        rustup
                        cargo
                        rust-analyzer
                        vimPlugins.rustaceanvim
                    ];

                    dontSetPrompt = true;

                    shellHook = ''
                        export FLAKE_DESC="[exercism-rust] "
                        eval "$(starship init bash)"
                        exercism configure -w /home/jazzkid/projects/personal/exercism
                    '';
                };
        };
}
