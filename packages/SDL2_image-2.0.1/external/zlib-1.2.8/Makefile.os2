LIBNAME = zlib
VERSION = 1.2.8
INCPATH = ..\..\h
LIBPATH = ..\..\lib
EXEPATH = ..\..\exe

TITLENAME = $(LIBNAME) $(VERSION)
INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

SRCS = adler32.c compress.c crc32.c deflate.c gzclose.c gzlib.c gzread.c &
       gzwrite.c infback.c inffast.c inflate.c inftrees.c trees.c uncompr.c &
       zutil.c

OBJS = $(SRCS:.c=.obj)

.extensions:
.extensions: .lib .dll .obj .c

.c: .\test

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -5s -fp5 -fpi87 -sg -s -oilrtfm -wx

all: $(LIBFILE) $(EXEPATH)\minigzip.exe

$(LIBFILE): $(OBJS)
  @echo * Create library: $(LIBFILE_STATIC)...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f >nul

$(EXEPATH)\minigzip.exe: $(LIBFILE) minigzip.obj
  @echo * Link: $@
  @wlink SYS os2v2 libpath $(LIBPATH) lib {$(LIBFILE)} op q op el file {minigzip} name $*

.c.obj:
  @wcc386 $(CFLAGS) $<

minigzip.c:
  wcc386 $(CFLAGS) -DOS2 -DSTDC $@

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
  @if exist $(EXEPATH)\minigzip.exe @del $(EXEPATH)\minigzip.exe
