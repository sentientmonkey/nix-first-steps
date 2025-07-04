{
  pkgs ? import <nixpkgs> { },
}:

let
  helloNix = pkgs.callPackage ./. { };
in
pkgs.dockerTools.buildImage {
  name = "hello-nix";
  config = {
    Cmd = [ "${helloNix}/bin/hello-nix" ];
  };
}
