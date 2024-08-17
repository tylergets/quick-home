{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devenv.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      flake = {
        nixosModules.quick-home = import ./service.nix self;
      };

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        packages = rec {
          quick-home = pkgs.buildNpmPackage rec {
            pname = "quick-home";
            version = "0.1.2";

            src = ./app;
            npmDepsHash = "sha256-WHKrNwuk8inAbaE6ihvrnaxncvGmdEF1q5XPbkCH4bA=";

            # The prepack script runs the build script, which we'd rather do in the build phase.
            npmPackFlags = ["--ignore-scripts"];

            NODE_OPTIONS = "--openssl-legacy-provider";

            meta = {
              description = "A simple home page for homelab servers";
              homepage = "https://github.com/tylergets/quick-home";
            };
          };
          default = quick-home;
          docker = pkgs.dockerTools.buildLayeredImage {
            name = "ghcr.io/tylergets/quick-home";
            tag = "latest";
            contents = [self.packages.x86_64-linux.quick-home];
            config.Cmd = "${self.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/quick-home";
          };
        };

        formatter = pkgs.alejandra;

        devenv.shells.default = {
          packages = [
          ];

          languages = {
            python.enable = true;
            javascript = {
              enable = true;
              package = pkgs.nodejs_latest;
              npm = {
                enable = true;
#                install.enable = true;
              };
              bun = {
                enable = true;
              };
            };
          };

          processes = {
          };
        };
      };
    };
}
