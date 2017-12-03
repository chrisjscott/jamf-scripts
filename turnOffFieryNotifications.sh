#!/bin/bash
# This script will turn off Fiery driver update notifications for the currently-logged on user

loggedInUser=$(/usr/bin/stat -f%Su /dev/console)
fieryPrefs=/Users/$loggedInUser/Library/Preferences/com.efi.FieryPrinterDriverUpdater

if [ -f "$fieryPrefs" ]; then
   sed -i '' 's/NotifyAll=1/NotifyAll=0/g' $fieryPrefs
fi
