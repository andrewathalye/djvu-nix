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
  version = "0.5-20250505-git";

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
    rev = "8cf749a01e543f9ecb6cae30a9d11778d7c2896b";
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
