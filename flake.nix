{
  description = "A simple home page for homelab servers";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    nixosModules.quick-home = import ./service.nix self;
  } // flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in
    {
      packages = rec {
        quick-home = pkgs.buildNpmPackage rec {
          pname = "quick-home";
          version = "0.1.0";

          src = ./quick-home;
          npmDepsHash = "sha256-BOPPfVlbrOZ07//Iv0x3wqEia5Z/PQ0T4V8r+TEKcTY=";

          # The prepack script runs the build script, which we'd rather do in the build phase.
          npmPackFlags = [ "--ignore-scripts" ];

          NODE_OPTIONS = "--openssl-legacy-provider";

          meta = {
            description = "A simple home page for homelab servers";
            homepage = "https://github.com/tylergets/quick-home";
          };
        };
        default = quick-home;
      };
    });
}
