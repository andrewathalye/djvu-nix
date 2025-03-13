{ config
, stdenv
, lib
, djvulibre
, makeWrapper
}:
stdenv.mkDerivation rec {
  pname = "depress";
  version = "1.8";

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs = [
    djvulibre
  ];

  src = builtins.fetchGit {
    url = "https://github.com/plzombie/depress.git";
    ref = "refs/tags/v1.8";
    rev = "a6144b2c6a4570e9b551d34532764ebf6f981c9e";
  };

  configurePhase = ''
    cd BUILD_UNIX_MAKEFILE
  '';

  enableParallelBuilding = true;

  installPhase = ''
      mkdir -p 2>/dev/null "$out"
      mkdir -p 2>/dev/null "$out/bin"

      install -m 755 depress "$out/bin/"
  '';

  postFixup = ''
    wrapProgram $out/bin/depress --prefix PATH : ${lib.makeBinPath [ djvulibre ]}
  '';
}
