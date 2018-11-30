#!/bin/sh
#
# CScott / Sept. 13, 2017
# Script prompts user for their location and then updates JAMF computer record to assign them to that site
#
# Note that the updated Site value can take a minute or two before it updates in the JSS.

computerSite=`/usr/bin/osascript << EOT
with timeout of 28800 seconds
   tell application "System Events"
      activate
      set sites to {"Location01", "Location02", "Location03"}
      set computerSite to choose from list sites with prompt "Select this system's location:"
   end tell
end timeout
EOT`

# Find your site names and IDs by visiting https://<jamfURL>/api/#!/sites/findSites_get

if [ "${computerSite}" == "Location01" ]; then 
   siteID="##"
elif [ "${computerSite}" == "Location02" ]; then 
   siteID="##"
elif [ "${computerSite}" == "Location03" ]; then 
   siteID="##"
fi

# Reference: https://www.jamf.com/jamf-nation/discussions/23031/api-assign-computers-from-group-x-to-site-y

serial=$(system_profiler SPHardwareDataType | grep 'Serial Number (system)' | awk '{print $NF}')
curl -H "Content-Type: application/xml" -u <login>:<password> https://<jamfURL>/JSSResource/computers/serialnumber/$serial/subset/general -d "<computer><general><site><id>$siteID</id><name>$computerSite</name></site></general></computer>" -X PUT
