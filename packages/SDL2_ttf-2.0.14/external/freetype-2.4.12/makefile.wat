LIBNAME = freetype
VERSION = 2.4.12
INCPATH = .\include

TITLENAME = $(LIBNAME) $(VERSION)
INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH);$(INCPATH)

LIBFILE = ..\..\..\..\lib\$(LIBNAME).lib

SRCS = autofit.c ftapi.c ftbase.c ftbbox.c ftbdf.c ftdebug.c &
       ftglyph.c ftinit.c ftmm.c ftpfr.c ftstroke.c ftsynth.c ftsystem.c &
       fttype1.c ftwinfnt.c ftxf86.c bdf.c ftcache.c cff.c type1cid.c ftgzip.c &
       ftlzw.c pcf.c pfr.c psaux.c pshinter.c psnames.c raster.c sfnt.c &
       smooth.c truetype.c type1.c type42.c winfnt.c &
       ftobjs.c ftpfr.c ftbitmap.c

OBJS = $(SRCS:.c=.obj)

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier
CFLAGS+= -wcd=124 -DFT2_BUILD_LIBRARY

$(LIBFILE): $(OBJS)
  @echo * Create library: $@...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f >nul

.extensions:
.extensions: .lib .dll .obj .c

.c: src\autofit;src\autohint;src\base;src\bdf;src\cache;src\cff;src\cid;&
src\gzip;src\lzw;src\otvalid;src\pcf;src\pfr;src\psaux;src\pshinter;&
src\psnames;src\raster;src\sfnt;src\smooth;src\truetype;src\type1;src\type42;&
src\winfonts;

.c.obj:
  @wcc386 $(CFLAGS) $<

.before:
  @echo *** $(TITLENAME)

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
