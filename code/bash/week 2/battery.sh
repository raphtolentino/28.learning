#!/bin/bash

BATTERY_LEVEL=75

if [ "$BATTERY_LEVEL" -lt 20 ]; then
    echo "Battery is low!"
else
    echo "Battery is OK."
fi
