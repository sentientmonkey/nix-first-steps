{
  pkgs ? import <nixpkgs> { },
}:
pkgs.rustPlatform.buildRustPackage {
  pname = "hello-nix";
  version = "0.0.1";
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/hello-nix \
      --prefix PATH : ${pkgs.lolcat}/bin \
      --prefix PATH : ${pkgs.figlet}/bin \
      --add-flags "| figlet | lolcat"
  '';
}
