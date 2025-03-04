{ stdenv
, lib
, python3Packages
, tesseract
, djvulibre
, makeWrapper
}:
python3Packages.buildPythonApplication rec {
  pname = "ocrodjvu";
  version = "0.14";

  propagatedBuildInputs = [
    python3Packages.lxml
    python3Packages.python-djvulibre
    python3Packages.pyicu
    python3Packages.html5lib
  ];

  src = builtins.fetchGit { url = "https://github.com/FriedrichFroebel/ocrodjvu.git"; ref = "refs/tags/0.14"; rev = "925756865683782ac82efa2686262a295a7eed44"; };

  postFixup = ''
    wrapProgram $out/bin/ocrodjvu \
      --set PATH ${lib.makeBinPath [
        djvulibre
        tesseract
      ]}

    wrapProgram $out/bin/djvu2hocr \
      --set PATH ${lib.makeBinPath [
        djvulibre
      ]}
  '';
}
