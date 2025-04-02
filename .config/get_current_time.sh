#!/usr/bin/env bash

CURRENT_DATE=$(date +"%H:%M:%S")
CURRENT_DAY=$(date "+%A,%e of %B")
notify-send "It is ${CURRENT_DATE}", "We're ${CURRENT_DAY}"
echo "Hey, ${CURRENT_DATE}"
