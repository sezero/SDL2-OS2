# Makefile.am for the SDL sample image loading library and viewer

lib_LTLIBRARIES = libSDL2_net.la

libSDL2_netincludedir = $(includedir)/SDL2
libSDL2_netinclude_HEADERS =		\
	SDL_net.h

libSDL2_net_la_SOURCES =		\
	SDLnet.c		\
	SDLnetTCP.c		\
	SDLnetUDP.c		\
	SDLnetselect.c		\
	SDLnetsys.h

EXTRA_DIST =			\
	Android.mk		\
	debian			\
	version.rc		\
	VisualC			\
	Xcode			\
	Xcode-iOS		\
	SDL2_net.spec		\
	SDL2_net.spec.in		\
	gcc-fat.sh		\
	autogen.sh			\
	$(srcdir)/*.txt

if USE_VERSION_RC
libSDL2_net_la_LDFLAGS = 	\
	-no-undefined		\
	-release $(LT_RELEASE)	\
	-version-info $(LT_CURRENT):$(LT_REVISION):$(LT_AGE) -Wl,version.o
libSDL2_net_la_LIBADD = @INETLIB@
libSDL2_net_la_DEPENDENCIES = version.o
else
libSDL2_net_la_LDFLAGS = 	\
	-no-undefined		\
	-release $(LT_RELEASE)	\
	-version-info $(LT_CURRENT):$(LT_REVISION):$(LT_AGE)
libSDL2_net_la_LIBADD = @INETLIB@
endif

%.o : %.rc
	$(WINDRES) $< $@

if ENABLE_EXAMPLES
EXAMPLES = showinterfaces chat chatd
noinst_PROGRAMS = $(EXAMPLES)
endif

showinterfaces_SOURCES = showinterfaces.c
showinterfaces_LDADD = libSDL2_net.la
chat_SOURCES = chat.c chat.h
chat_LDADD = libSDL2_net.la -lSDL2_test
chatd_SOURCES = chatd.c
chatd_LDADD = libSDL2_net.la

# Rule to build tar-gzipped distribution package
$(PACKAGE)-$(VERSION).tar.gz: distcheck

# Rule to build RPM distribution package
rpm: $(PACKAGE)-$(VERSION).tar.gz
	rpmbuild -ta $(PACKAGE)-$(VERSION).tar.gz

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = SDL2_net.pc
