LIBNAME = smpeg
VERSION = 2.0.0
LIBPATH = ..\..\..\..\lib
EXEPATH = ..\..\..\..\exe
INCPATH = .;..\..\..\..\h;..\..\..\..\h\SDL2

INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH);$(INCPATH)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

CCSRCS = MPEG.cpp MPEGlist.cpp MPEGring.cpp MPEGstream.cpp MPEGsystem.cpp &
         smpeg.cpp bitwindow.cpp filter.cpp filter_2.cpp hufftable.cpp &
         MPEGaudio.cpp mpeglayer1.cpp mpeglayer2.cpp mpeglayer3.cpp &
         mpegtable.cpp mpegtoraw.cpp decoders.cpp floatdct.cpp gdith.cpp &
         jrevdct.cpp motionvec.cpp MPEGvideo.cpp parseblock.cpp readfile.cpp &
         util.cpp video.cpp

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier
CFLAGS+= -ei -DNOCONTROLS -DTHREADED_AUDIO
CCFLAGS = $(CFLAGS)

CCOBJS = $(CCSRCS:.cpp=.obj)
#COBJS = $(CSRCS:.c=.obj)

$(EXEPATH)\plaympeg.exe: $(LIBFILE) plaympeg.obj
  @echo * Link: $@
  @wlink SYS os2v2 libpath $(LIBPATH) lib {$(LIBFILE) sdl2.lib} op q op el file {plaympeg} name $*

$(LIBFILE): $(CCOBJS) $(COBJS)
  @echo * Create library: $@...
  @for %f in ($(CCOBJS)) do @wlib -b -q $* +%f
  @for %f in ($(COBJS)) do @wlib -b -q $* +%f

.extensions:
.extensions: .lib .dll .obj .cpp .c

.cpp: .\audio;.\video

.cpp.obj:
  @wpp386 $(CCFLAGS) $<

.c.obj:
  @wcc386 $(CFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
  @if exist $(EXEPATH)\plaympeg.exe @del $(EXEPATH)\plaympeg.exe
