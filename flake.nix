{
  description = "release-train-test";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "release-train-test";
          version = "devel";
          src = ./.;
          vendorHash = "sha256-uP/+QtXJiQGWL3mJKXGxAbz0C0FIJ90GM1b73odA2rY=";
          ldflags = [ "-X main.version=${self.packages.${system}.default.version}" ];
          subPackages = [ "cmd/release-train-test" ];
        };
      }
    );
}
