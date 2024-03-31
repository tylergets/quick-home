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
          npmDepsHash = "sha256-WHKrNwuk8inAbaE6ihvrnaxncvGmdEF1q5XPbkCH4bA=";

          # The prepack script runs the build script, which we'd rather do in the build phase.
          npmPackFlags = [ "--ignore-scripts" ];

          NODE_OPTIONS = "--openssl-legacy-provider";

          meta = {
            description = "A simple home page for homelab servers";
            homepage = "https://github.com/tylergets/quick-home";
          };
        };
        default = quick-home;
        docker = pkgs.dockerTools.buildLayeredImage {
              name = "quick-home";
              tag = "latest";
              contents = [ self.nixosModules.quick-home ];
              config.Cmd = "${self.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/quick-home";
        };
      };
    });
}
