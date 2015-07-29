#!/bin/sh
# This script is licensed under GNU GPL version 2.0 or above
#
# set admin email so that you can get email
ADMIN="your@email.com"
# alert level 90% is default
ALERT=90
df -H | grep -vE '^Filesystem|Sys. fich.|tmpfs|udev|cdrom|rootfs' | awk '{ print $6 " " $5 }' | while read output;
do
  #echo $output
  usep=$(echo $output | awk '{ print $2}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $1 }' )
  if [ $usep -ge $ALERT ]; then
     echo "Running out of space "$partition "("$usep"%) on "$(hostname) "as on" $(date)
     mail -s "Alert: Almost out of disk space $usep" $ADMIN
  fi
done
