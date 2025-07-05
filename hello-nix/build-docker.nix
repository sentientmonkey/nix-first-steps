{
  helloNix,
  pkgs ? import <nixpkgs> { },
}:

pkgs.dockerTools.buildImage {
  name = "hello-nix";
  tag = helloNix.version;

  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    paths = with pkgs; [
      helloNix
      bashInteractive
      coreutils
    ];
    pathsToLink = [ "/bin" ];
  };
  config = {
    Cmd = [ "/bin/hello-nix" ];
  };
}
