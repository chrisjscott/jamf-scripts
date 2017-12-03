#!/bin/bash
# written by C. Scott on Nov. 2016
# This script sets the duplex printing option to ON for any installed Canon printer drivers
# Different printers use different flag sytax for this, thus the reason for the multiple instances of the command
# Note that the deactivation flag for some is 'None' and 'False' for others; enabling flag is 'DuplexNoTumble', 'DuplexFront' or 'LongEdge'
# Also note that some non-Canon printers use the same flag, thus the grep-within-grep (to limit action to Canon printers)
# (probably not necessary, as we're explicitly only looking for PPDs w/ duplex turned on but better safe-than-sorry

grep -l '*DefaultDuplex: None' /etc/cups/ppd/*.ppd | xargs grep -l 'Canon' | xargs sed -i '' 's/*DefaultDuplex: None/*DefaultDuplex: DuplexNoTumble/g'
grep -l '*DefaultCNDuplex: None' /etc/cups/ppd/*.ppd | xargs grep -l 'Canon' | xargs sed -i '' 's/*DefaultCNDuplex: None/*DefaultCNDuplex: DuplexFront/g'
grep -l '*DefaultEFDuplex: False' /etc/cups/ppd/*.ppd | xargs grep -l 'Canon' | xargs sed -i '' 's/*DefaultEFDuplex: False/*DefaultEFDuplex: LongEdge/g'