{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        helloNix = pkgs.callPackage ./hello-nix { inherit pkgs; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            cargo
            rustc
            rust-analyzer
            rustfmt
            figlet
            lolcat
          ];
        };
        packages.default = helloNix;
        packages.dockerImage = pkgs.callPackage ./hello-nix/build-docker.nix { inherit helloNix pkgs; };
      }
    );
}
