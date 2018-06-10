LIBNAME = sdl2img
VERSION = 2.0.1
INCPATH = ..\..\h;..\..\h\SDL2
LIBPATH = ..\..\lib
EXEPATH = ..\..\exe
DLLPATH = ..\..\dll

TITLENAME = $(LIBNAME) $(VERSION)
INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib
DLLFILE = $(DLLPATH)\$(LIBNAME).dll
LNKFILE = $(LIBNAME).lnk

SRCS = 	IMG.c IMG_bmp.c IMG_gif.c IMG_jpg.c IMG_lbm.c IMG_pcx.c IMG_png.c &
        IMG_pnm.c IMG_tga.c IMG_tif.c IMG_xcf.c IMG_xpm.c IMG_xv.c IMG_webp.c

LIBS = libpng.lib libtiff.lib zlib.lib jpeg.lib SDL2.lib

CFLAGS = -i=$(INCPATH) -bt=os2 -ei -d0 -q -5s -fp5 -fpi87 -sg -s -oilrtfm -wx
CFLAGS+= -bd -ei -wcd=202 -wcd=136 -DBUILD_SDL &
          -DLOAD_JPG -DLOAD_PNG -DLOAD_BMP -DLOAD_GIF -DLOAD_LBM &
          -DLOAD_PCX -DLOAD_PNM -DLOAD_TGA -DLOAD_XCF -DLOAD_XPM &
          -DLOAD_XV -DLOAD_XXX -DLOAD_TIF


.extensions:
.extensions: .lib .dll .obj .c

.c: .\timidity

OBJS = $(SRCS:.c=.obj)

$(LIBFILE): $(DLLFILE)
  @echo * Create library: $@...
  @wlib -b -n -q $@ $(DLLFILE)

$(DLLFILE): $(OBJS) $(LNKFILE)
  @echo * Link: $@
  @wlink @$(LNKFILE)

$(LNKFILE):
  @%create $@
  @%append $@ SYSTEM os2v2_dll INITINSTANCE TERMINSTANCE
  @%append $@ NAME $(DLLPATH)\$(LIBNAME)
  @for %i in ($(OBJS)) do @%append $@ FILE %i
  @%append $@ OPTION QUIET
!ifdef %osdir
  @$(%osdir)\KLIBC\BIN\date +"OPTION DESCRIPTION '@$#libsdl org:$(VERSION)$#@$#$#1$#$# %F               $(%HOSTNAME)::::::@@Simple DirectMedia Layer Image Library'" >>$^@
!else
  @%append $@ OPTION DESCRIPTION '@$#libsdl org:$(VERSION)$#@Simple DirectMedia Layer Image Library'
!endif
  @%append $@ LIBPATH $(LIBPATH)
  @for %i in ($(LIBS)) do @%append $@ LIB %i
  @%append $@ OPTION MAP=$*
  @%append $@ OPTION ELIMINATE
  @%append $@ OPTION MANYAUTODATA
  @%append $@ OPTION OSNAME='OS/2 and eComStation'
  @%append $@ OPTION SHOWDEAD

# In new libpng some function arguments defined with "const"
# (for ex. png_structp -> png_const_structrp for png_create_info_struct() )
# Disable warning 102 about it...
IMG_png.obj:
  @wcc386 $(CFLAGS) -wcd=102 $*.c

.c.obj:
  @wcc386 $(CFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist *.map @del *.map
  @if exist $(LNKFILE) @del $(LNKFILE)
  @if exist $(DLLFILE) @del $(DLLFILE)
  @if exist $(LIBFILE) @del $(LIBFILE)
