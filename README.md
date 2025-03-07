DjVu-Nix
========
A collection of DjVu-related software for Nix.

Recommended:
-- pdftodjvu
-- gsdjvu *
-- ocrodjvu

* gsdjvu is license-incompatible with GhostScript. It must be built
from source and cannot subsequently be distributed in binary form.

Still Useful:
-- pdftotree
-- hocr2djvused

pdftodjvu
---------
This is currently roughly beta quality.

A custom tool I wrote to convert PDF to DjVu and retain hyperlinks and text.
It uses pdfalto, djvudigital, and custom XSLT to generate DjVu files with
text data and hyperlinks.

pdf2djvu is slower and produces larger files, but is somewhat more stable.
Use it instead if file size is not a concern. Note also that pdf2djvu can struggle
with languages other than English, while pdftodjvu does not generally have issues.

KNOWN ISSUES:
-- Requires accurate PDF fonts to determine bounds correctly
-- Can incorrectly deduce bounding boxes for some highly-complex scripts or formats.
> This is an upstream pdfalto bug, reported [here](https://github.com/kermitt2/pdfalto/issues/192)
