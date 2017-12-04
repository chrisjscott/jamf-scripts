#!/bin/sh
#
# CScott / Nov. 2017
# Use this with policies that interrupt the user (w/ pop-ups, for example) to minimize
# the chance that the user is interrupted when presenting.
#
# Modify presentationApps to include the names of apps commonly-known to be used as
# presentation tools and then insert code to be executed in the 'else'

currentUser=$(stat -f %Su /dev/console)
# The following lin determines if "Do Not Disturb" is turned on; 0=Off, 1=On
# Note that this isn't foolproof; if user has DND set up on a schedule then this won't detect when it's on as per the schedule
notificationStatus=$(sudo -u $currentUser defaults read /Users/$currentUser/Library/Preferences/ByHost/com.apple.notificationcenterui.plist doNotDisturb)
frontApp=$(launchctl asuser $(id -u $currentUser) osascript -e 'get POSIX path of (path to frontmost application)')

presentationApps="Adobe Acrobat|Google Chrome.app|Keynote.app|Microsoft Powerpoint.app|Preview.app|Sketch.app"

if [[ $frontApp =~ $presentationApps ]] || [[ "$notificationStatus" = "1" ]];
then
   true # user could be presenting; skip process and revisit later
else
   # insert code to execute here
fi
