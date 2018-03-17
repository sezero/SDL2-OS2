LIBNAME = flac
VERSION = 1.2.1
INCPATH = ..\..\..\..\h;.\include;.\src\libFLAC\include
LIBPATH = ..\..\..\..\lib

INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH);$(INCPATH)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

CFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier
CFLAGS += -DVERSION="$(VERSION)"
CFLAGS += -DHAVE_CONFIG_H -DFLAC__NO_DLL -DFLAC__HAS_OGG

SRCS = bitmath.c bitreader.c bitwriter.c cpu.c crc.c fixed.c float.c format.c &
       lpc.c md5.c memory.c metadata_iterators.c metadata_object.c &
       ogg_decoder_aspect.c ogg_encoder_aspect.c ogg_helper.c &
       ogg_mapping.c stream_decoder.c stream_encoder.c &
       stream_encoder_framing.c window.c

OBJS = $(SRCS:.c=.obj)

.c: .\src\libFLAC

$(LIBFILE): $(OBJS)
  @echo * Create library: $@...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f

stream_decoder.obj: stream_decoder.c
  @wcc386 $(CFLAGS) -wcd=136 $<

.c.obj:
  @wcc386 $(CFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(LIBNAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
