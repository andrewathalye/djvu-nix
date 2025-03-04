{ stdenv
, lib
, jre
, python311Packages
, makeWrapper
}:
with python311Packages;
let
   selectivesearch = buildPythonApplication rec {
     pname = "selectivesearch";
     version = "0.4";
     
     src = builtins.fetchGit {
      url = "https://github.com/AlpacaTechJP/selectivesearch.git";
      ref = "refs/tags/v0.4";
      rev = "554c1286b8c5068cb1eade8d01e89025a159d850";
     };
   };
in
buildPythonApplication rec {
  pname = "pdftotree";
  version = "0.5.0";

  patches = [ ./setup.py.patch ];

  propagatedBuildInputs = [
    ipython
    beautifulsoup4
    keras
    numpy
    pandas
    pdfminer-six
    pillow
    selectivesearch
    scikit-learn
    tabula-py
    tensorflowWithoutCuda
    wand
    pip
  ];

  src = builtins.fetchGit {
    url = "https://github.com/HazyResearch/pdftotree.git";
    ref = "refs/tags/v0.5.0";
    rev = "20bbd8d3cd9e9136268472bfa38f9646131cb625";
  };

  postFixup = ''
    wrapProgram $out/bin/pdftotree --set JAVA_HOME ${jre.out}
  '';
}
