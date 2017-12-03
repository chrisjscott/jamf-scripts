#!/bin/bash
# written by C. Scott on Nov. 2016
# This script sets the duplex printing option to off for any installed Canon printer drivers
# Different printers use different flag sytax for this, thus the reason for the multiple instances of the command
# Note that the deactivation flag for some is 'None' and 'False' for others
# Also note that some non-Canon printers use the same flag, thus the grep-within-grep (to limit action to Canon printers)
# (probably not necessary, as we're explicitly only looking for PPDs w/ duplex turned on but better safe-than-sorry

grep -l '*DefaultDuplex: DuplexNoTumble' /etc/cups/ppd/*.ppd | xargs grep -l 'Canon' | xargs sed -i '' 's/*DefaultDuplex: DuplexNoTumble/*DefaultDuplex: None/g'
grep -l '*DefaultCNDuplex: DuplexFront' /etc/cups/ppd/*.ppd | xargs grep -l 'Canon' | xargs sed -i '' 's/*DefaultCNDuplex: DuplexFront/*DefaultCNDuplex: None/g'
grep -l '*DefaultEFDuplex: LongEdge' /etc/cups/ppd/*.ppd | xargs grep -l 'Canon' | xargs sed -i '' 's/*DefaultEFDuplex: LongEdge/*DefaultEFDuplex: False/g'