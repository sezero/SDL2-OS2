#
# Makefile for installing the mingw32 version of the SDL2_net library

CROSS_PATH := /usr/local
ARCHITECTURES := i686-w64-mingw32 x86_64-w64-mingw32

all install:
	@echo "Type \"make native\" to install 32-bit to /usr"
	@echo "Type \"make cross\" to install 32-bit and 64-bit to $(CROSS_PATH)"

native:
	make install-package arch=i686-w64-mingw32 prefix=/usr

cross:
	mkdir -p $(CROSS_PATH)/cmake
	cp -rv cmake/* $(CROSS_PATH)/cmake
	for arch in $(ARCHITECTURES); do \
	    make install-package arch=$$arch prefix=$(CROSS_PATH)/$$arch; \
	done

install-package:
	@if test -d $(arch) && test -d $(prefix); then \
	    (cd $(arch) && cp -rv bin include lib $(prefix)/); \
	    sed "s|^prefix=.*|prefix=$(prefix)|" <$(arch)/lib/pkgconfig/SDL2_net.pc >$(prefix)/lib/pkgconfig/SDL2_net.pc; \
	    sed "s|^libdir=.*|libdir=\'$(prefix)/lib\'|" <$(arch)/lib/libSDL2_net.la >$(prefix)/lib/libSDL2_net.la; \
		sed -e "s|^set[(]bindir \".*|set(bindir \"$(prefix)/bin\")|" \
			-e "s|^set[(]includedir \".*|set(includedir \"$(prefix)/include\")|" \
			-e "s|^set[(]libdir \".*|set(libdir \"$(prefix)/lib\")|" <$(arch)/lib/cmake/SDL2_net/sdl2_net-config.cmake >$(prefix)/lib/cmake/SDL2_net/sdl2_net-config.cmake; \
		sed -e "s|^prefix=.*|prefix=$(prefix)|" \
			-e "s|^includedir=.*|includedir=$(prefix)/include|" \
			-e "s|^libdir=.*|prefix=$(prefix)/lib|" <$(arch)/lib/pkgconfig/SDL2_net.pc >$(prefix)/lib/pkgconfig/SDL2_net.pc; \
	else \
	    echo "*** ERROR: $(arch) or $(prefix) does not exist!"; \
	    exit 1; \
	fi
