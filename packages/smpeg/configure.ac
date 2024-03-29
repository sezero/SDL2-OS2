dnl Process this file with autoconf to produce a configure script.
AC_INIT
AC_CONFIG_SRCDIR([MPEG.cpp])

dnl Set various version strings - taken gratefully from the GTk sources
#
# Making releases:
#   MICRO_VERSION += 1;
#   INTERFACE_AGE += 1;
#   BINARY_AGE += 1;
# if any functions have been added, set INTERFACE_AGE to 0.
# if backwards compatibility has been broken,
# set BINARY_AGE and INTERFACE_AGE to 0.
#
MAJOR_VERSION=2
MINOR_VERSION=0
MICRO_VERSION=0
INTERFACE_AGE=0
BINARY_AGE=0
VERSION=$MAJOR_VERSION.$MINOR_VERSION.$MICRO_VERSION

AC_SUBST(MAJOR_VERSION)
AC_SUBST(MINOR_VERSION)
AC_SUBST(MICRO_VERSION)
AC_SUBST(INTERFACE_AGE)
AC_SUBST(BINARY_AGE)
AC_SUBST(VERSION)

ASFLAGS=""
CCASFLAGS=""
AC_SUBST(ASFLAGS)
AC_SUBST(CCASFLAGS)

# libtool versioning
LT_RELEASE=$MAJOR_VERSION.$MINOR_VERSION
LT_CURRENT=`expr $MICRO_VERSION - $INTERFACE_AGE`
LT_REVISION=$INTERFACE_AGE
LT_AGE=`expr $BINARY_AGE - $INTERFACE_AGE`

AC_SUBST(LT_RELEASE)
AC_SUBST(LT_CURRENT)
AC_SUBST(LT_REVISION)
AC_SUBST(LT_AGE)

dnl Detect the canonical build and host environments
AC_CANONICAL_HOST

dnl Setup for automake
AM_INIT_AUTOMAKE(smpeg2, $VERSION)

dnl Check for tools

AC_PROG_MAKE_SET
AC_PROG_CC
AC_PROG_CXX
AM_PROG_AS
LT_INIT([win32-dll])
AC_PROG_INSTALL

dnl Work around the lack of certain typedefs.
AC_TYPE_SOCKLEN_T

dnl The alpha architecture needs special flags for binary portability
case "$host" in
    alpha*-*-linux*)
	if test x$ac_cv_c_compiler_gnu = xyes; then
            CFLAGS="$CFLAGS -mcpu=ev4 -Wa,-mall"
        fi
        ;;
    sparc*-*-solaris*)
        LIBS="$LIBS -lsocket -lnsl"
        ;;
    *-*-qnx*)
        LIBS="$LIBS -lsocket"
        ;;
    *-*-beos*)
        ac_default_prefix=/boot/develop/tools/gnupro
        ;;
    *-*-cygwin* | *-*-mingw32*)
        if test "$build" != "$host"; then # cross-compiling
            ac_default_prefix=/usr/local/cross-tools/i386-mingw32msvc
        fi
        ;;
esac

dnl Set runtime shared library paths as needed 
AC_ARG_ENABLE(rpath,
	AS_HELP_STRING([--enable-rpath],
		[use an rpath when linking SDL [[default=yes]]]),,
	enable_rpath=yes)

if test "x$enable_rpath" = "xyes"; then
  case "$host" in
      *-*-linux*)
	  SMPEG_RLD_FLAGS="-Wl,-rpath,\${exec_prefix}/lib"
	  ;;
      *-*-freebsd*)
	  SMPEG_RLD_FLAGS="-Wl,-rpath,\${exec_prefix}/lib"
	  ;;
      *-*-solaris*)
	  SMPEG_RLD_FLAGS="-R\${exec_prefix}/lib"
	  ;;
  esac
else
  SMPEG_RLD_FLAGS=""
fi

AC_SUBST(SMPEG_RLD_FLAGS)

dnl Add compiler-specific optimization flags

AC_ARG_ENABLE(debug,
[AS_HELP_STRING([--enable-debug],[Disable aggressive optimizations [default=yes]])],
              , enable_debug=yes)
if test x$enable_debug != xyes; then
    if test x$ac_cv_c_compiler_gnu = xyes; then
        CFLAGS="$CFLAGS -fexpensive-optimizations -fomit-frame-pointer"
    fi
    case "$host" in
        i486-*-*)  # Yeah right. :)
            if test x$ac_cv_c_compiler_gnu = xyes; then
                CFLAGS="$CFLAGS -march=486"
            fi
            ;;
        i?86-*-*)
            if test x$ac_cv_c_compiler_gnu = xyes; then
                CFLAGS="$CFLAGS -march=pentium -mcpu=pentiumpro"
            fi
            ;;
    esac
fi

dnl Check for SDL
SDL_VERSION=2.0.0
AM_PATH_SDL2($SDL_VERSION,
            :,
	    AC_MSG_ERROR([*** SDL version $SDL_VERSION not found!])
)
CFLAGS="$CFLAGS $SDL_CFLAGS"
LIBS="$LIBS $SDL_LIBS"

dnl See if we need to pass -lm for the math library
AC_CHECK_LIB(m, sqrt, LIBS="$LIBS -lm")

dnl Check for MMX support
AC_ARG_ENABLE(mmx,
[AS_HELP_STRING([--enable-mmx],[enable MMX IDCT decoding routines [default=no]])],
              , enable_mmx=no)
if test x$enable_mmx = xyes; then
    AC_MSG_CHECKING(for MMX optimizations)
    use_mmx=no
    case "$host" in
        i?86-*-*)
            use_mmx=yes
            ;;
    esac
    AC_MSG_RESULT($use_mmx)

    if test x$use_mmx = xyes; then
        CFLAGS="$CFLAGS -DUSE_MMX"
        ASFLAGS="$ASFLAGS -DUSE_MMX"
        CCASFLAGS="$CCASFLAGS -DUSE_MMX"
    fi
fi

dnl Check for system timestamp sync
AC_ARG_ENABLE(timestamp-sync,
[AS_HELP_STRING([--enable-timestamp-sync],[enable system timestamp sync [default=no]])],
              , enable_timestamp_sync=no)
if test x$enable_timestamp_sync = xyes; then
	CFLAGS="$CFLAGS -DUSE_TIMESTAMP_SYNC"
fi

dnl Enable the use of the system thread
AC_ARG_ENABLE(threaded-system,
[AS_HELP_STRING([--enable-threaded-system],[enable system thread [default=no]])],
              , enable_threaded_system=no)
if test x$enable_threaded_system = xyes; then
	CFLAGS="$CFLAGS -DUSE_SYSTEM_THREAD"
fi

dnl Disable using a thread for the video callback
AC_ARG_ENABLE(video-callback-thread,
[AS_HELP_STRING([--enable-video-callback-thread],[enable video callback thread [default=yes]])],
              , enable_video_callback_thread=yes)
if test x$enable_video_callback_thread = xno; then
	CFLAGS="$CFLAGS -DDISABLE_VIDEO_CALLBACK_THREAD"
fi

dnl Enable threaded audio
AC_ARG_ENABLE(threaded-audio,
[AS_HELP_STRING([--enable-threaded-audio],[enable threaded audio [default=yes]])],
              , enable_threaded_audio=yes)
if test x$enable_threaded_audio = xyes; then
	CFLAGS="$CFLAGS -DTHREADED_AUDIO"
fi

dnl Disable assertions in release builds
AC_ARG_ENABLE(assertions,
[AS_HELP_STRING([--enable-assertions],[Enable consistency checks in decoding [default=no]])],
              , enable_assertions=no)
if test x$enable_assertions != xyes; then
    CFLAGS="$CFLAGS -DNDEBUG"
fi

dnl Activate compiler warnings
CFLAGS="$CFLAGS -Wall"

dnl Add the source include directories
CFLAGS="$CFLAGS -I.."
CFLAGS="$CFLAGS -I\$(top_srcdir) -I\$(top_srcdir)/audio -I\$(top_srcdir)/video"
CXXFLAGS="$CFLAGS"


dnl C++ flags are the same as the C flags
CXXFLAGS="$CFLAGS"
if test x$GCC = xyes; then
    # Check to see if options -fno-rtti -fno-exceptions are supported
    AC_MSG_CHECKING(if $CXX supports -fno-rtti -fno-exceptions)
    use_fnoexceptions=no
    save_CFLAGS="$CFLAGS"
    save_CC="$CC"
    CFLAGS="-fno-rtti -fno-exceptions"
    CC="$CXX"
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([],[])],
                      [use_fnoexceptions=yes])
    AC_MSG_RESULT($use_fnoexceptions)
    if test x$use_fnoexceptions = xyes; then
        CXXFLAGS="$CXXFLAGS -fno-exceptions -fno-rtti"
    fi
    CC="$save_CC"
    CFLAGS="$save_CFLAGS"
fi


# Finally create all the generated files
AC_CONFIG_FILES([
Makefile
smpeg2-config
smpeg2.spec
])
AC_OUTPUT
