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
  version = "0.6.0";

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
    rev = "8f7a2133da8d82e0c9c400b733512f97ea83fe52";
    submodules = true;
  };

  enableParallelBuilding = true;

  postConfigure = ''
    cp xpdf-*/aconf.h ../xpdf-*/
  '';

  installPhase = ''
    mkdir -p "$out/bin"
    install -m755 pdfalto "$out/bin"
  '';
}
