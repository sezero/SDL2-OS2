LIBNAME = sdl2ttf
VERSION = 2.0.14
INCPATH = ..\..\h;..\..\h\SDL2
LIBPATH = ..\..\lib
DLLPATH = ..\..\dll

TITLENAME = $(LIBNAME) $(VERSION)
INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH);

LIBFILE = $(LIBPATH)\$(LIBNAME).lib
DLLFILE = ..\..\dll\$(LIBNAME).dll
LNKFILE = $(LIBNAME).lnk

SRCS = SDL_ttf.c

OBJS = $(SRCS:.c=.obj)

LIBS = freetype.lib SDL2.lib

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier -ei
CFLAGS+= -bd -j -DBUILD_SDL

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
  @$(%osdir)\KLIBC\BIN\date +"OPTION DESCRIPTION '@$#libsdl org:$(VERSION)$#@$#$#1$#$# %F               $(%HOSTNAME)::::::@@Simple DirectMedia Layer truetype font loading library'" >>$^@
!else
  @%append $@ OPTION DESCRIPTION '@$#libsdl org:$(VERSION)$#@Simple DirectMedia Layer truetype font loading library'
!endif
  @%append $@ LIBPATH $(LIBPATH)
  @for %i in ($(LIBS)) do @%append $@ LIB %i
  @%append $@ OPTION MAP=$*
  @%append $@ OPTION ELIMINATE
  @%append $@ OPTION MANYAUTODATA
  @%append $@ OPTION OSNAME='OS/2 and eComStation'
  @%append $@ OPTION SHOWDEAD

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
