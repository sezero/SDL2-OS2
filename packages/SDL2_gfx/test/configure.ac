dnl Process this file with autoconf to produce a configure script.
AC_INIT(testframerate.c)

dnl Detect the canonical build and host environments
AC_CANONICAL_HOST

dnl Check for tools
AC_PROG_CC

dnl Check for compiler environment
AC_C_CONST

dnl Figure out which math library to use
case "$host" in
    *-*-cygwin* | *-*-mingw32*)
        EXE=".exe"
        MATHLIB=""
        ;;
    *-*-beos* | *-*-haiku*)
        EXE=""
        MATHLIB=""
        ;;
    *-*-darwin*)
        EXE=""
        MATHLIB=""
        ;;
    *-*-aix*)
        EXE=""
        if test x$ac_cv_prog_gcc = xyes; then
            CFLAGS="-mthreads"
        fi
        ;;
    *-*-mint*)
        EXE=""
        MATHLIB=""
        ;;
    *-*-qnx*)
        EXE=""
        MATHLIB=""
        ;;
    *-*-os2*)
        EXE=".exe"
        MATHLIB=""
        ;;
    *)
        EXE=""
        MATHLIB="-lm"
        ;;
esac
AC_SUBST(EXE)
AC_SUBST(MATHLIB)

dnl Check for SDL
SDL_VERSION=2.0.0
AM_PATH_SDL2($SDL_VERSION,
            :,
	    AC_MSG_ERROR([*** SDL version $SDL_VERSION not found!])
)
CFLAGS="$CFLAGS $SDL_CFLAGS"
LIBS="$LIBS -lSDL2_test $SDL_LIBS"

dnl Check for SDL2_gfx
have_sdlgfx=no
AC_CHECK_LIB(SDL2_gfx, pixelColor , have_sdlgfx=yes)
if test x$have_sdlgfx = xyes; then
    LIBS="$LIBS -lSDL2_gfx"
else
    AC_MSG_ERROR([
*** Unable to find SDL2_gfx library
])
fi

dnl Finally create all the generated files
AC_OUTPUT([Makefile])
