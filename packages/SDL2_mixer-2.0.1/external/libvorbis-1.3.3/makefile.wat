LIBNAME = vorbis
VERSION = 1.3.3
INCPATH = .;..\..\..\..\h
LIBPATH = ..\..\..\..\lib

TITLENAME = $(LIBNAME) $(VERSION)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH)

SRCS = analysis.c barkmel.c bitrate.c block.c codebook.c envelope.c floor0.c &
       floor1.c info.c lookup.c lpc.c lsp.c mapping0.c mdct.c psy.c &
       registry.c res0.c sharedbook.c smallft.c synthesis.c &
       vorbisenc.c vorbisfile.c window.c
# psytune.c misc.c tone.c

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier -j
CFLAGS+= -DHAVE_ALLOCA_H -DUSE_MEMORY_H

OBJS = $(SRCS:.c=.obj)

.c: .\lib

$(LIBFILE): $(OBJS)
  @echo * Create library: $(LIBFILE)...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f >nul

.c.obj:
  @wcc386 $(CFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
