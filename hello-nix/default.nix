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
    # Move the original binary to a new location
    mv $out/bin/hello-nix $out/bin/.hello-nix-unwrapped

    # Create a wrapper script
    makeWrapper $out/bin/.hello-nix-unwrapped $out/bin/hello-nix \
      --prefix PATH : ${pkgs.lolcat}/bin \
      --prefix PATH : ${pkgs.figlet}/bin \
      --add-flags "| figlet | lolcat"
  '';
}
