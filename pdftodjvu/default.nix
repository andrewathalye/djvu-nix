{ stdenv
, lib
, gsdjvu
, djvulibre
, pdfalto 
, libxslt
, makeWrapper
}:
stdenv.mkDerivation rec {
  pname = "pdftodjvu";
  version = "0.3";

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ gsdjvu djvulibre pdfalto libxslt ];

  script = ./pdftodjvu;
  xml = ./alto_to_djvu.xml;

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin
    mkdir $out/share

    cp ${script} $out/bin/pdftodjvu
    cp ${xml} $out/share/alto_to_djvu.xml

    sed -i "s#@SHARE_DIR@#$out/share#g" $out/bin/pdftodjvu

    wrapProgram $out/bin/pdftodjvu \
      --prefix PATH : ${lib.makeBinPath [ gsdjvu djvulibre pdfalto libxslt ]}
  '';

}
