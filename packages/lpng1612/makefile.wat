LIBNAME = libpng
VERSION = 1.6.12
INCPATH = ..\..\h
LIBPATH = ..\..\lib
EXEPATH = ..\..\exe

TITLENAME = $(LIBNAME) $(VERSION)
INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

SRCS = png.c pngerror.c pngget.c pngmem.c pngpread.c pngread.c pngrio.c &
       pngrtran.c pngrutil.c pngset.c pngtrans.c pngwio.c pngwrite.c &
       pngwtran.c pngwutil.c

OBJS = $(SRCS:.c=.obj)

CFLAGS = -i=$(INCPATH) -bt=os2 -ei -d0 -q -5s -fp5 -fpi87 -sg -s -oilrtfm -wx -wcd=124


all: $(LIBFILE) $(EXEPATH)\pngtest.exe

$(LIBFILE): $(OBJS)
  @echo * Create library: $@...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f >nul

$(EXEPATH)\pngtest.exe: $(LIBFILE_STATIC) pngtest.obj
  @echo * Link: $@
  @wlink SYS os2v2 libpath $(LIBPATH) lib {$(LIBFILE) zlib} op q op el file {pngtest} name $*

.c.obj:
  @wcc386 $(CFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
  @if exist $(EXEPATH)\pngtest.exe @del $(EXEPATH)\pngtest.exe
