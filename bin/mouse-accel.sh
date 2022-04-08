#!/bin/bash

device="Logitech G502 HERO Gaming Mouse"
prop="libinput Accel Speed"

echo "Before:"
xinput list-props "$device" | grep "$prop"
xinput set-prop "$device" "$prop" 1
echo "After:"
xinput list-props "$device" | grep "$prop"
