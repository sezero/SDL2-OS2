LIBNAME = sdl2mix
VERSION = 2.0.1
INCPATH = .\timidity;..\..\h;..\..\h\SDL2
LIBPATH = ..\..\lib
DLLPATH = ..\..\dll

TITLENAME = $(LIBNAME) $(VERSION)
INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH);

LIBFILE = $(LIBPATH)\$(LIBNAME).lib
DLLFILE = ..\..\dll\$(LIBNAME).dll
LNKFILE = $(LIBNAME).lnk

SRCS = dynamic_flac.c dynamic_fluidsynth.c dynamic_mod.c dynamic_modplug.c &
       dynamic_mp3.c dynamic_ogg.c effects_internal.c effect_position.c &
       effect_stereoreverse.c fluidsynth.c load_aiff.c load_flac.c load_mp3.c &
       load_ogg.c load_voc.c mixer.c music.c music_cmd.c music_flac.c &
       music_mad.c music_mod.c music_modplug.c music_ogg.c wavestream.c
# playwave.c playmus.c
SRCS+= common.c ctrlmode.c filter.c instrum.c mix.c output.c playmidi.c &
       readmidi.c resample.c sdl_a.c sdl_c.c tables.c timidity.c

OBJS = $(SRCS:.c=.obj)

LIBS = FLAC.lib libogg.lib mikmod.lib smpeg.lib vorbis.lib sdl2.lib

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier -ei
CFLAGS+= -bd -j -DBUILD_SDL
CFLAGS+= -dWAV_MUSIC -dMOD_MUSIC -dMID_MUSIC &
         -dUSE_TIMIDITY_MIDI &
         -dOGG_MUSIC -dMP3_MUSIC -dFLAC_MUSIC

.c: .;.\timidity

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
  @$(%osdir)\KLIBC\BIN\date +"OPTION DESCRIPTION '@$#libsdl org:$(VERSION)$#@$#$#1$#$# %F               $(%HOSTNAME)::::::@@Simple DirectMedia Layer Mixer'" >>$^@
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

wavestream.obj: wavestream.c
  @wcc386 $(CFLAGS) -wcd=118 $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist *.map @del *.map
  @if exist $(LNKFILE) @del $(LNKFILE)
  @if exist $(DLLFILE) @del $(DLLFILE)
  @if exist $(LIBFILE) @del $(LIBFILE)
