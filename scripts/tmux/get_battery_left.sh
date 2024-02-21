#!/bin/bash

state=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state" | awk '{print $2}'`
time_to=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time to" | awk '{print $4}'`
timescale=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time to" | awk '{print $5}'`

if [[ -n "$state" ]]; then
  if [ "$state" = "discharging" ] || [ "$state" = "charging" ]
  then
    if [[ "$timescale" == "minutes" ]]; then
      echo "$time_to m"
    elif [[ "$timescale" == "hours" ]]; then
      echo "$time_to h"
    fi
  elif [ "$state" = "pending-charge" ]; then
    echo " "
  fi
else
  exit 1
fi

