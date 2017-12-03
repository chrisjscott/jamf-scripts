#!/bin/sh
#
# CScott / Nov. 2017
# Use this with policies that interrupt the user (w/ pop-ups, for example) to minimize
# the chance that the user is interrupted when presenting.
#
# Modify presentationApps to include the names of apps commonly-known to be used as
# presentation tools and then insert code to be executed in the 'else'

currentUser=$(stat -f %Su /dev/console)
frontApp=$(launchctl asuser $(id -u $currentUser) osascript -e 'get POSIX path of (path to frontmost application)')

presentationApps="Adobe Acrobat|Google Chrome.app|Keynote.app|Microsoft Powerpoint.app|Preview.app|Sketch.app"

if [[ $frontApp =~ $presentationApps ]];
then
   true # user could be presenting; skip process and revisit later
else
   # insert code to execute here
fi
