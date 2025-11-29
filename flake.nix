{
  description = "release-train-test";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "release-train-test";
          version = "0.1.0";
          src = ./.;
          vendorHash = "sha256-pJlJvpFH4ltsFINYEcdMzh5waripYjjwUkdNqTyYr2Q=";
          ldflags = [ "-X main.version=${self.packages.${system}.default.version}" ];
          subPackages = [ "cmd/release-train-test" ];
        };
      });
}
