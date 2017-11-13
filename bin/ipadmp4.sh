#!/bin/sh

if [ "$1" = "" ]; then
	echo usage $0 '<inputfile> <outfile>'
	exit
fi
if [ "$2" = "" ]; then
	echo usage $0 '<inputfile> <outfile>'
	exit
fi

ffmpeg -i "$1" -vcodec libx264 -r 25 -b:v 516k -bt 516k -crf 22 -strict experimental "$2"
