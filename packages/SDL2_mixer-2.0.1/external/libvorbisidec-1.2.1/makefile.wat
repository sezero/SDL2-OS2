LIBNAME = libvorbisdec
VERSION = 1.2.1
INCPATH = .;..\..\..\..\h
LIBPATH = ..\..\..\..\lib

TITLENAME = $(LIBNAME) $(VERSION)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH)

SRCS = codebook.c floor0.c floor1.c info.c iseeking_example.c &
       mapping0.c mdct.c registry.c res012.c sharedbook.c synthesis.c &
       vorbisfile.c window.c

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier -j
CFLAGS+= -DHAVE_ALLOCA_H -DUSE_MEMORY_H

OBJS = $(SRCS:.c=.obj)

$(LIBFILE): $(OBJS)
  @echo * Create library: $(LIBFILE)...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f >nul

.c.obj:
  wcc386 $(CFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
