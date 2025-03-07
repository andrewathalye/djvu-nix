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

pdf2djvu is slower and produces larger files, but is significantly more stable.
Use it instead if file size is not a concern. Note also that pdf2djvu can struggle
with languages other than English, while pdftodjvu does not generally have issues.

KNOWN ISSUES:
-- Can struggle with determining bounds for some non-English text
> I’ve only observed this so far in text with lots of diacritics (e.g. Church Slavonic)
-- Requires accurate PDF fonts to determine bounds correctly
-- With extremely large DPIs (>1200) can suffer rounding errors with text boxes.

