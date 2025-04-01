#!/usr/bin/env bash

CURRENT_DATE=$(date | awk '{print $4}')
CURRENT_DAY=$(date "+%A,%e of %B")
notify-send "It is ${CURRENT_DATE}", "We're ${CURRENT_DAY}"
echo "Hey, ${CURRENT_DATE}"
