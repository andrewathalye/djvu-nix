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
  version = "0.4-202401231-git";

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
    ref = "master";
    rev = "85b3938cfece8b193f6d18aab97abed596d3e8af";
    submodules = true;
  };

  enableParallelBuilding = true;

  installPhase = ''
    mkdir -p "$out/bin"
    install -m755 pdfalto "$out/bin"
  '';
}
