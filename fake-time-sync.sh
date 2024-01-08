#!/bin/bash --
#

MYNAME=$(basename $0 .sh)

exec < /dev/null

# Create duplicate local log as date/time set messes with system journal
#
date >> /tmp/$MYNAME.log

(
# Random selection of directories that should have recent timestamp
FSTIME=$(find /tmp /var/log /var/lib/rpm -printf '%Ts\n' | sort -u | tail -1 )
OSTIME=$(date +%s)

if [ -n "$OSTIME" -a -n "$FSTIME" ] ; then
	if [ "$FSTIME" -gt "$OSTIME" ] ; then
		echo "$MYNAME: Set system clock time to $(date -d @$FSTIME)"
		date --set=@$FSTIME
	else
		echo "$MYNAME: No clock update needed"
	fi
else
	echo "$MYNAME: Clock time: $OSTIME Filesystem time: $FSTIME"
fi
) | tee -a /tmp/$MYNAME.log 2>&1

date >> /tmp/$MYNAME.log
echo '-----------------------------------' >> /tmp/$MYNAME.log 2>&1
