LIBNAME = libogg
VERSION = 1.3.1
INCPATH = .\include
LIBPATH = ..\..\..\..\lib

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH)

SRCS = bitwise.c framing.c

OBJS = $(SRCS:.c=.obj)

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier

$(LIBFILE): $(OBJS)
  @echo * Create library: $@...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f >nul

.c: .\src

.c.obj:
  @wcc386 $(CFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
