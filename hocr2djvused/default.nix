{ stdenv
, lib
, python3Packages
, djvulibre
, makeWrapper
}:
python3Packages.buildPythonApplication rec {
  pname = "hocr2djvused";
  version = "20200513-git";

  propagatedBuildInputs = [
    python3Packages.python-djvulibre
    python3Packages.pyicu
    python3Packages.six
    python3Packages.lxml
    python3Packages.html5lib
  ];

  src = builtins.fetchGit {
    url = "https://github.com/rockclimb/hocr2djvused.git";
    ref = "hocr2djvused_py3";
    rev = "fe3d385a763f0b379c00bcf3298b6027e4a39ef1";
  };

  postFixup = ''
    wrapProgram $out/bin/hocr2djvused \
      --set PATH ${lib.makeBinPath [
        djvulibre
      ]}

    wrapProgram $out/bin/djvu2hocr \
      --set PATH ${lib.makeBinPath [
        djvulibre
      ]}

  '';
}
