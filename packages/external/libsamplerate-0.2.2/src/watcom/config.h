/* hand-edited config.h for OS/2 using Watcom compiler. */

/* Version number of package */
#define VERSION "0.2.1"
/* Name of package */
#define PACKAGE "libsamplerate"

/* Define to 1 if you have the `lrint' function. */
/* #undef HAVE_LRINT */

/* Define to 1 if you have the `lrintf' function. */
/* #undef HAVE_LRINTF */

#if defined(__WATCOMC__) && defined(__386__) && \
  !(defined(HAVE_LRINTF) || defined(HAVE_LRINT))
#define HAVE_LRINT_ASM
#undef  lrint
#define lrint  double2int
#undef  lrintf
#define lrintf float2int

extern __inline long double2int(double);
#pragma aux double2int = \
    "push  eax" \
    "fistp dword ptr [esp]" \
    "pop   eax" \
    parm [8087] \
    value [eax] \
    modify exact [eax];

extern __inline long float2int(float);
#pragma aux float2int = \
    "push  eax" \
    "fistp dword ptr [esp]" \
    "pop   eax" \
    parm [8087] \
    value [eax] \
    modify exact [eax];
#endif			/* */

/* Host processor clips on negative float to int conversion. */
#if defined(HAVE_LRINT_ASM)
#define CPU_CLIPS_NEGATIVE 1
#else
#define CPU_CLIPS_NEGATIVE 0
#endif

/* Host processor clips on positive float to int conversion. */
#define CPU_CLIPS_POSITIVE 0

/* Host processor is big endian. */
#define CPU_IS_BIG_ENDIAN 0

/* Host processor is little endian. */
#define CPU_IS_LITTLE_ENDIAN 1

/* Enable sinc best converter. */
#define ENABLE_SINC_BEST_CONVERTER 1

/* Enable sinc fast converter. */
#define ENABLE_SINC_FAST_CONVERTER 1

/* Enable sinc balanced converter. */
#define ENABLE_SINC_MEDIUM_CONVERTER 1

/* Set to 1 if you have fftw3 */
/* #undef HAVE_FFTW3 */

/* Set to 1 if you have libsndfile */
/* #undef HAVE_SNDFILE */

/* Define to 1 if you have the `calloc' function. */
#define HAVE_CALLOC 1

/* Define to 1 if you have the `ceil' function. */
#define HAVE_CEIL 1

/* Define to 1 if you have the `floor' function. */
#define HAVE_FLOOR 1

/* Define to 1 if you have the `fmod' function. */
#define HAVE_FMOD 1

/* Define to 1 if you have the `free' function. */
#define HAVE_FREE 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the `malloc' function. */
#define HAVE_MALLOC 1

/* Define to 1 if you have the `memcpy' function. */
#define HAVE_MEMCPY 1

/* Define to 1 if you have the `memmove' function. */
#define HAVE_MEMMOVE 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `alarm' function. */
/* #undef HAVE_ALARM */

/* Define if you have signal SIGALRM. */
/* #undef HAVE_SIGALRM */

/* Define to 1 if you have the `signal' function. */
#define HAVE_SIGNAL 1

/* Define to 1 if you have the <stdbool.h> header file. */
#define HAVE_STDBOOL_H 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/times.h> header file. */
/* #undef HAVE_SYS_TIMES_H */

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if the compiler supports simple visibility declarations. */
/* #undef HAVE_VISIBILITY */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* The size of `double', as computed by sizeof. */
#define SIZEOF_DOUBLE 8

/* The size of `float', as computed by sizeof. */
#define SIZEOF_FLOAT 4

/* The size of `int', as computed by sizeof. */
#define SIZEOF_INT 4

/* The size of `long', as computed by sizeof. */
#define SIZEOF_LONG 4

/* Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
   significant byte first (like Motorola and SPARC, unlike Intel). */
/* #undef WORDS_BIGENDIAN */

