LIBNAME = libtiff
VERSION = 4.0.3
INCPATH = ..\..\h
LIBPATH = ..\..\lib
EXEPATH = ..\..\exe

TITLENAME = $(LIBNAME) $(VERSION)
INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH);$(INCPATH)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

SRCS = tif_aux.c tif_close.c tif_codec.c tif_color.c tif_compress.c tif_dir.c &
       tif_dirinfo.c tif_dirread.c tif_dirwrite.c tif_dumpmode.c tif_error.c &
       tif_extension.c tif_fax3.c tif_fax3sm.c tif_flush.c tif_getimage.c &
       tif_jbig.c tif_jpeg.c tif_jpeg_12.c tif_luv.c tif_lzma.c tif_lzw.c &
       tif_next.c tif_ojpeg.c tif_open.c tif_packbits.c tif_pixarlog.c &
       tif_predict.c tif_print.c tif_read.c tif_strip.c tif_swab.c &
       tif_thunder.c tif_tile.c tif_version.c tif_warning.c tif_write.c &
       tif_zip.c tif_unix.c

OBJS = $(SRCS:.c=.obj)

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier

.c: .\libtiff

$(LIBFILE): $(OBJS)
  @echo * Create library: $@...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f >nul

tif_read.obj: tif_read.c
  @wcc386 $(CFLAGS) -wcd=136 $<

.c.obj:
  @wcc386 $(CFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
