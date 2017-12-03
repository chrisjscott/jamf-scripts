#!/bin/bash

# written by C. Scott / March 2017
#
# This script will completely remove MS Office 2011 according to these instructions:
# https://support.microsoft.com/en-us/help/2398768/how-to-completely-remove-office-for-mac-2011
#
# This will also delete both MS Communicator and MS Messenger.
#
# Note that, if the user has icons for these 2011 apps in their Dock that those will have to be manually removed.

shortName=$(defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName)

# Step 1
osascript -e 'quit app "Microsoft Communicator"'
osascript -e 'quit app "Microsoft Excel"'
osascript -e 'quit app "Microsoft Messenger"'
osascript -e 'quit app "Microsoft Outlook"'
osascript -e 'quit app "Microsoft PowerPoint"'
osascript -e 'quit app "Microsoft Word"'

# Step 2
rm -rf /Applications/Microsoft\ Office\ 2011/*
rm -rf /Applications/Microsoft\ Office\ 2011/
rm -rf /Applications/Microsoft\ Communicator.app/
rm -rf /Applications/Microsoft\ Messenger.app/

# Step 3
rm /Users/$shortName/Library/Preferences/com.microsoft.*
rm /Library/LaunchDaemons/com.microsoft.office.licensing.helper.plist
rm /Library/PrivilegedHelperTools/com.microsoft.office.licensing.helper

# Step 4
rm /Library/Preferences/com.microsoft.office.licensing.plist
rm /Users/$shortName/Library/Preferences/ByHost/com.microsoft*

# supposed to restart at this point; we'll skip this

# Step 5
rm -rf /Library/Application\ Support/Microsoft/

# Step 6
rm /Library/Receipts/Office2011_*
rm /private/var/db/receipts/com.microsoft.office*

# Step 7
rm -rf /Users/$shortName/Library/Application\ Support/Microsoft/Office/

# Step 8
rm -rf /Library/Fonts/Microsoft/

# Step 9
rm /Users/$shortName/.Trash/*
