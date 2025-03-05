{ stdenv
, libpng
, zlib
, libxml2
, freetype
, icu
, cmake
, fontconfig
}:
stdenv.mkDerivation {
  pname = "pdfalto";
  version = "0.4";

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    libpng
    zlib
    libxml2
    freetype
    fontconfig
    icu
  ];

  src = builtins.fetchGit {
    url = "https://www.github.com/kermitt2/pdfalto.git";
    ref = "refs/tags/0.4";
    rev = "2ef1c4a516b787b981e2724c8143f67b6f776f17";
    submodules = true;
  };

  enableParallelBuilding = true;

  installPhase = ''
    mkdir -p "$out/bin"
    install -m755 pdfalto "$out/bin"
  '';
}
