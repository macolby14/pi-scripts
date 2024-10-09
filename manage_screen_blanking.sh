#!/bin/bash

set -euo pipefail

SCREEN_BLANKING_TIME_MIN=5
SCREEN_OFF_HOUR=21 # 9pm
SCREEN_ON_HOUR=06 # 6am

CURRENT_HOUR=$(date +%H)
SCREEN_BLANKING_TIME_SEC=$(( SCREEN_BLANKING_TIME_MIN * 60 ))

export DISPLAY=:0

if [[ "${CURRENT_HOUR}" == "${SCREEN_OFF_HOUR}" ]]; then
	# enable screen blanking
	xset s $SCREEN_BLANKING_TIME_SEC  # 10 minutes
	xset +dpms
	xset dpms $SCREEN_BLANKING_TIME_SEC $SCREEN_BLANKING_TIME_SEC $SCREEN_BLANKING_TIME_SEC
        xset dpms force off # turn off screen immediatelly	
elif [[ "${CURRENT_HOUR}" == "${SCREEN_ON_HOUR}" ]]; then
	xset s off
	xset -dpms # turn off power saver and turn screen on
else
	echo "Running ${0} at an unexpected time" 1>&2
fi



