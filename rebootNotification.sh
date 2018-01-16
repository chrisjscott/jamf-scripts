#!/bin/sh
# This script will spawn a pop-up message reminding the user that they have not restarted in x days.
# It is designed to NOT appear if macOS' DND is on or if the frontmost app is one of a preset selection
# (set in the $presentationApps variable). This is so as to not disturb a potential presentation.
#
# Prerequisites include an extension attribute that stores the system's last restart date, a smart computer group
# that reports any systems whose last restart EA is greater than X days (you choose) and a policy configured to run
# this script with the above-mentioned smart computer group specified as the scope. Recommended frequency is once per day.

# note that the utility windowtype has a nine-line max

daysSinceLastReboot=$(( (`date +%s` - `sysctl kern.boottime | awk '{print $5}' | sed 's/,$//'`) / 86400 ))

currentUser=$(stat -f %Su /dev/console)

# The following line determines if "Do Not Disturb" is turned on; 0=Off, 1=On
# Note that this isn't foolproof; if user has DND set up on a schedule then this won't detect when it's on as per the schedule
notificationStatus=$(defaults -currentHost read /Users/$currentUser/Library/Preferences/ByHost/com.apple.notificationcenterui.plist doNotDisturb)

frontApp=$(launchctl asuser $(id -u $currentUser) osascript -e 'get POSIX path of (path to frontmost application)')

presentationApps="Adobe Acrobat|Google Chrome.app|Keynote.app|Microsoft Powerpoint.app|Preview.app|Sketch.app"

# We have to check for daysSinceLastReboot=0 because the user may reboot and JAMF may fail to update the "last reboot" EA before the
# policy that spawns this reboot message is checked.
if [[ $frontApp =~ $presentationApps ]] || [[ "$notificationStatus" = "1" ]] || [[ "$daysSinceLastReboot" = "0" ]];
then
   true # user could be presenting; skip process and revisit later
else
/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "Please reboot your system" -description "This is a friendly reminder that you have not restarted your computer in $daysSinceLastReboot days.

Not rebooting on a regular basis increases the chance of unexpected data loss - please take a minute to save any open files and restart your system." -button1 "Got it!" -defaultButton 1
fi
