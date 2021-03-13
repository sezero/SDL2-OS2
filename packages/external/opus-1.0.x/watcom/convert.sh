#!/bin/sh

src="celt_sources.mk silk_sources.mk opus_sources.mk package_version"
for f in $src ;do
 sed -e "s|_SOURCES|_OBJS|" -e "s|\.c|\.obj|" -e "s|\\\|\&|" -e "s|src\/||" -e "s|celt\/||" -e "s|silk\/||" -e "s|float\/||" -e "s|fixed\/||" ../$f >$f
done
