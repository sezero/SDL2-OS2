/*
  SDL_mixer:  An audio mixer library based on the SDL library
  Copyright (C) 1997-2016 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
	 claim that you wrote the original software. If you use this software
	 in a product, an acknowledgment in the product documentation would be
	 appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
	 misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

  This is the source needed to decode an MP3 into a waveform.
*/

/* $Id$ */

#if defined(MP3_MPG_MUSIC) || defined(MP3_MAD_MUSIC)

#include "SDL_mixer.h"

#include "load_mp3.h"

#if defined(MP3_MPG_MUSIC)
#include "music_mpg.h"
#elif defined(MP3_MAD_MUSIC)
#include "music_mad.h"
#endif

SDL_AudioSpec *Mix_LoadMP3_RW(SDL_RWops *src, int freesrc, SDL_AudioSpec *spec, Uint8 **audio_buf, Uint32 *audio_len)
{
	/* note: spec is initialized to mixer spec */

#if defined(MP3_MPG_MUSIC)
	mpg_data *mp3_mpg;
#elif defined(MP3_MAD_MUSIC)
	mad_data *mp3_mad;
#endif
	long samplesize;
	int read_len;
	const Uint32 chunk_len = 4096;
	int err = 0;

	if ((!src) || (!spec) || (!audio_buf) || (!audio_len))
	{
		return NULL;
	}

	if (!err)
	{
		*audio_len = 0;
		*audio_buf = (Uint8*) SDL_malloc(chunk_len);
		err = (*audio_buf == NULL);
	}

	if (!err)
	{
		err = ((Mix_Init(MIX_INIT_MP3) & MIX_INIT_MP3) == 0);
	}

	if (!err)
	{
#if defined(MP3_MPG_MUSIC)
		mp3_mpg = mpg_new_rw(src, spec, freesrc);
		err = (mp3_mpg == NULL);
#elif defined(MP3_MAD_MUSIC)
		mp3_mad = mad_openFileRW(src, spec, freesrc);
		err = (mp3_mad == NULL);
#endif
	}

	if (!err)
	{
#if defined(MP3_MPG_MUSIC)
		mpg_start(mp3_mpg);

		/* read once for audio length */
		while ((read_len = mpg_get_samples(mp3_mpg, *audio_buf, chunk_len)) > 0)
		{
			*audio_len += read_len;
		}

		mpg_stop(mp3_mpg);

#elif defined(MP3_MAD_MUSIC)
		mad_start(mp3_mad);

		/* read once for audio length */
		while ((read_len = mad_getSamples(mp3_mad, *audio_buf, chunk_len)) > 0)
		{
			*audio_len += read_len;
		}

		mad_stop(mp3_mad);
#endif

		err = (read_len < 0);
	}

	if (!err)
	{
		/* reallocate, if needed */
		if ((*audio_len > 0) && (*audio_len != chunk_len))
		{
			*audio_buf = (Uint8*) SDL_realloc(*audio_buf, *audio_len);
			err = (*audio_buf == NULL);
		}
	}

	if (!err)
	{
		/* read again for audio buffer, if needed */
		if (*audio_len > chunk_len)
		{
#if defined(MP3_MPG_MUSIC)
			mpg_seek(mp3_mpg, 0);
			mpg_start(mp3_mpg);
			err = (*audio_len != mpg_get_samples(mp3_mpg, *audio_buf, *audio_len));
			mpg_stop(mp3_mpg);
#elif defined(MP3_MAD_MUSIC)
			mad_seek(mp3_mad, 0);
			mad_start(mp3_mad);
			err = (*audio_len != mad_getSamples(mp3_mad, *audio_buf, *audio_len));
			mad_stop(mp3_mad);
#endif
		}
	}

	if (!err)
	{
		/* Don't return a buffer that isn't a multiple of samplesize */
		samplesize = ((spec->format & 0xFF)/8)*spec->channels;
		*audio_len &= ~(samplesize-1);
	}

#if defined(MP3_MPG_MUSIC)
	if (mp3_mpg)
	{
		mpg_delete(mp3_mpg); mp3_mpg = NULL;
		/* Deleting the MP3 closed the source if desired */
		freesrc = SDL_FALSE;
	}
#elif defined(MP3_MAD_MUSIC)
	if (mp3_mad)
	{
		mad_closeFile(mp3_mad); mp3_mad = NULL;
		/* Deleting the MP3 closed the source if desired */
		freesrc = SDL_FALSE;
	}
#endif

	if (freesrc)
	{
		SDL_RWclose(src); src = NULL;
	}

	/* handle error */
	if (err)
	{
		if (*audio_buf != NULL)
		{
			SDL_free(*audio_buf); *audio_buf = NULL;
		}
		*audio_len = 0;
		spec = NULL;
	}

	return spec;
}

#endif