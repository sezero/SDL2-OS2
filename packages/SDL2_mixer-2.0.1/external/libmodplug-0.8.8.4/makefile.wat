LIBNAME = libmodplug
VERSION = 0.8.8.4
INCPATH = .;.\src;.\src\libmodplug;..\..\..\..\h
LIBPATH = ..\..\..\..\lib

TITLENAME = $(LIBNAME) $(VERSION)

LIBFILE = $(LIBPATH)\$(LIBNAME).lib

INCPATH = $(%WATCOM)\H\os2;$(%WATCOM)\H;$(INCPATH)

SRCS = fastmix.cpp load_669.cpp load_abc.cpp load_amf.cpp load_ams.cpp &
       load_dbm.cpp load_dmf.cpp load_dsm.cpp load_far.cpp load_it.cpp &
       load_j2b.cpp load_mdl.cpp load_med.cpp load_mid.cpp load_mod.cpp &
       load_mt2.cpp load_mtm.cpp load_okt.cpp load_pat.cpp load_psm.cpp &
       load_ptm.cpp load_s3m.cpp load_stm.cpp load_ult.cpp load_umx.cpp &
       load_wav.cpp load_xm.cpp mmcmp.cpp modplug.cpp sndfile.cpp sndmix.cpp &
       snd_dsp.cpp snd_flt.cpp snd_fx.cpp

CCFLAGS = -i=$(INCPATH) -bt=os2 -d0 -q -bm -5s -fp5 -fpi87 -sg -oteanbmier
CCFLAGS+= -DHAVE_CONFIG_H

OBJS = $(SRCS:.cpp=.obj)

.extensions:
.extensions: .lib .obj .c .cpp

.cpp: .\src

$(LIBFILE): $(OBJS)
  @echo * Create library: $(LIBFILE)...
  @for %f in ($(OBJS)) do @wlib -b -q $* +%f >nul

.cpp.obj:
  @wpp386 $(CCFLAGS) $<

clean: .SYMBOLIC
  @echo * Clean: $(TITLENAME)
  @if exist *.obj @del *.obj
  @if exist *.err @del *.err
  @if exist $(LIBFILE) @del $(LIBFILE)
