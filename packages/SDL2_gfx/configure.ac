dnl Process this file with autoconf to produce a configure script.
AC_INIT(README)

dnl Set various version strings - taken gratefully from the GTk sources

# Making releases:
#   MICRO_VERSION += 1;
#   INTERFACE_AGE += 1;
#   BINARY_AGE += 1;
# if any functions have been added, set INTERFACE_AGE to 0.
# if backwards compatibility has been broken,
# set BINARY_AGE and INTERFACE_AGE to 0.

MAJOR_VERSION=1
MINOR_VERSION=0
MICRO_VERSION=2
INTERFACE_AGE=2
BINARY_AGE=2
VERSION=$MAJOR_VERSION.$MINOR_VERSION.$MICRO_VERSION

AC_SUBST(MAJOR_VERSION)
AC_SUBST(MINOR_VERSION)
AC_SUBST(MICRO_VERSION)
AC_SUBST(INTERFACE_AGE)
AC_SUBST(BINARY_AGE)
AC_SUBST(VERSION)

dnl libtool versioning
LT_INIT([win32-dll])

LT_RELEASE=$MAJOR_VERSION.$MINOR_VERSION
LT_CURRENT=`expr $MICRO_VERSION - $INTERFACE_AGE`
LT_REVISION=$INTERFACE_AGE
LT_AGE=`expr $BINARY_AGE - $INTERFACE_AGE`
LT_EXTRA="" dnl for OS2 dll name

AC_SUBST(LT_RELEASE)
AC_SUBST(LT_CURRENT)
AC_SUBST(LT_REVISION)
AC_SUBST(LT_AGE)
AC_SUBST(LT_EXTRA)

dnl Detect the canonical build and host environments
AC_CANONICAL_HOST

dnl Setup for automake
AM_INIT_AUTOMAKE(SDL2_gfx, $VERSION)

dnl Check for tools
AC_PROG_CC
AC_C_INLINE
AC_PROG_INSTALL
AC_PROG_MAKE_SET
if test -z "$host_alias"; then
    hostaliaswindres=
else
    hostaliaswindres="$host_alias-windres"
fi

case "$host" in
    *-*-beos*)
        ac_default_prefix=/boot/develop/tools/gnupro
        ;;
    *-*-cygwin* | *-*-mingw32*)
        if test "$build" != "$host"; then # cross-compiling
            # Default cross-compile location
            ac_default_prefix=/usr/local/cross-tools/i386-mingw32
        else
            # Look for the location of the tools and install there
            if test "$BUILD_PREFIX" != ""; then
                ac_default_prefix=$BUILD_PREFIX
            fi
        fi
        ;;
    *-*-os2*)
        # disable static builds on os/2
        enable_static=no
        # -DBUILD_SDL is needed for DECLSPEC
        CFLAGS="$CFLAGS -DBUILD_SDL"
        # OS/2 does not support a DLL name longer than 8 characters.
        LT_EXTRA="-os2dllname SDL2gfx"
        ;;
esac

dnl Check for NASM (for x86 assembly blit routines)
AC_ARG_ENABLE(mmx,[  --enable-mmx            use mmx assembly on x86 [default=yes], disable this on non-x86 platforms],, enable_mmx=yes)

if test x$enable_mmx = xyes; then
  CFLAGS="$CFLAGS -O -DUSE_MMX"
  dnl MMX enabled by default in GCC on x86_64, but not i386:
  AC_CHECK_SIZEOF([long])
  if test "$ac_cv_sizeof_long" = "4"; then
          CFLAGS="$CFLAGS -mmmx"
  fi
fi

dnl Check for SDL
SDL_VERSION=2.0.0
AC_SUBST(SDL_VERSION)
AM_PATH_SDL2($SDL_VERSION,
            :,
           AC_MSG_ERROR([*** SDL version $SDL_VERSION not found!])
)
CFLAGS="$CFLAGS $SDL_CFLAGS"
LIBS="$LIBS $SDL_LIBS"
saved_LIBS="$LIBS"

# Finally create all the generated files
AC_OUTPUT([
Makefile
SDL2_gfx.pc
])

echo
echo "Options summary:"
echo "* --enable-mmx: $enable_mmx"