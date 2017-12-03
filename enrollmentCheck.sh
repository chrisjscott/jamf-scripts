#!/bin/bash
#
# Throw this script in to Self Service so an end-user can verify that their system is
# properly enrolled in JAMF.

jssURL=https://<jamfURL>
jssUser=<login>
jssPassword=<password>

computer=`scutil --get ComputerName`

response=$(curl $jssURL/JSSResource/computers/name/$computer --user "$jssUser:$jssPassword")

computerName=$(echo $response | xpath '//computer/general/name' 2>&1 | awk -F'<name>|</name>' '{print $2}')
computerReportDate=$(echo $response | xpath '//computer/general/report_date' 2>&1 | awk -F'<report_date>|</report_date>' '{print $2}')
computerContactDate=$(echo $response | xpath '//computer/general/last_contact_time' 2>&1 | awk -F'<last_contact_time>|</last_contact_time>' '{print $2}')

jamf displayMessage -message "If any of this information appears to be incorrect then please submit a ticket to <emailAddress>.$computerName (System Name)$computerReportDate GMT (Last Inventory Update)$computerContactDate GMT (Last Check-In)"