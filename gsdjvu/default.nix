{ config
, stdenv
, lib
, ghostscript
, libpng
, libjpeg
, openjpeg
, zlib
, pkg-config
, autoconf
}:
stdenv.mkDerivation rec {
  pname = "gsdjvu";
  version = "1.10";

  nativeBuildInputs = [
   pkg-config
   autoconf
   zlib
  ];

  buildInputs = [
    libpng
    libjpeg
    openjpeg
    ghostscript.fonts
  ];

  src = builtins.fetchTarball { url = "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs923/ghostscript-9.23.tar.xz"; sha256 = "sha256:1iycxfzvh0848qij8kfgvraaq3dzwfbpax33ggchd1vyl2qi5vmj"; };
  djvusrc = ./gsdjvu-1.10.tar.gz;

  patchPhase = ''
    # Unpack source
    tar xf $djvusrc
    djvudir=gsdjvu-1.10
    mv $djvudir/*.* .
    mv $djvudir/contrib/* contrib/
    rm -r $djvudir

   cp gdevdjvu.c devices/gdevdjvu.c
   cp psdvifix.ps lib/psdvifix.ps

   msed="-e s/@@djvu@@/DEV/g"
   sed $msed < gsdjvu.mak >> devices/contrib.mak
  '';

  configurePhase = ''
   # Minimal build
   ./configure --with-drivers=FILES --without-x --without-ijs --without-gimp-print \
      --without-pdftoraster --without-omni --disable-cups --disable-gtk --disable-cairo \
      --disable-dynamic --prefix=$out

   # Remove extra drivers
   sed < Makefile > Makefile.tmp1 \
      -e 's!$(DD)[a-z0-9]*jet[a-z0-9]*\.dev!!g' \
      -e 's!$(DD)cdj[a-z0-9]*\.dev!!g' \
      -e 's!$(DD)bj[a-z0-9]*\.dev!!g' \
      -e 's!$(DD)pj[a-z0-9]*\.dev!!g' \
      -e 's!$(DD)lj[a-z0-9]*\.dev!!g' \
      -e 's!$(DD)pxl[a-z0-9]*\.dev!!g' \
      -e 's!$(DD)uniprint\.dev!!g' \
      -e 's!$(DD)x[a-z0-9]*\.dev!!g' \
      -e 's!$(DD)pdb[a-z0-9]*\.dev!!g' \
      -e 's!$(DD)pdb[a-z0-9]*\.dev!!g' \
      -e 's!^\(GS_LIB_DEFAULT=\).*$!\1/usr/lib/gsdjvu/lib:/usr/lib/gsdjvu/fonts  !'

   # Add djvu driver
   sed < Makefile.tmp1 > Makefile -e 's!$(DD)bbox.dev!& $(DD)djvumask.dev $(DD)djvusep.dev!g'
   rm Makefile.tmp1
  '';

  enableParallelBuilding = true;

  installPhase = ''
      mkdir -p 2>/dev/null "$out"
      mkdir -p 2>/dev/null "$out/bin"
      mkdir -p 2>/dev/null "$out/fonts"
      mkdir -p 2>/dev/null "$out/lib"

      install -m 755 bin/gs "$out/bin/gsdjvu"

      for n in fonts/* ; do
          install -m 644 $n "$out/fonts"
      done

      if test -d Resource ; then
          for n in `find Resource -type d -print` ; do
              mkdir -p "$out/$n"
          done
          for n in `find Resource -type f -print` ; do
              install -m 644 $n "$out/$n"
          done
          if test -r lib/gs_res.ps ; then
            test -r lib/gs_res.ps.gsdjvu || \
              cp lib/gs_res.ps lib/gs_res.ps.gsdjvu
            sed < lib/gs_res.ps.gsdjvu > lib/gs_res.ps \
              -e 's:(/\(Resource/[a-zA-Z/]*\)):(\1) findlibfile {pop} {pop &} ifelse:'
          fi
      fi  
      
      for n in lib/*
      do  
        test -x "$n" && test -r "$n.ps" && n=skip
        case "`basename $n`" in
            # Prune files we know are not needed
            *.ppd | *.upp | *.bat | *.sh | *.xbm | *.xpm | *.cmd ) ;;  
            ps2pdf* | ps2ps | pdf2ps | dvipdf | *.gsdjvu ) ;;
            gslj | gslp | gsbj | gsdj* | gsnd | skip ) ;;
            *) install -m 644 "$n" "$out/lib" ;;
        esac
      done
  '';
}
