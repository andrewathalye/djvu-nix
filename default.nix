{ pkgs }:
with pkgs;
rec {
  gsdjvu = callPackage ./gsdjvu {};
  hocr2djvused = callPackage ./hocr2djvused {};
  ocrodjvu = callPackage ./ocrodjvu {};
  pdftotree = callPackage ./pdftotree {};
  pdfalto = callPackage ./pdfalto {};
  pdftodjvu = callPackage ./pdftodjvu { gsdjvu = gsdjvu; pdfalto = pdfalto; };
}
