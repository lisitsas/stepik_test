#!/bin/bash
ARRAY=()
let count=0
while read -d ' ' LINE || [[ -n "$LINE" ]]; do
  ARRAY[$count]=$LINE
  ((count++))
done < <(sed -E '/^[[:blank:]]*(#|$)/d; s/#.*//' <&0)
host=${ARRAY[0]}
scheme=""
if [ ${ARRAY[3]} == "TRUE" ]
then 
  scheme="https"
else 
  scheme="http" 
fi
timestamp=${ARRAY[4]}
exp_date=`date "+%a %b %e %H:%M:%S %Z %Y" -u -d @$timestamp`
path=${ARRAY[2]}
csrftoken=${ARRAY[6]}
sessionid=${ARRAY[8]}

echo Host: "$host"
echo Scheme: "$scheme"
echo Expires: "$exp_date"
echo Path: "$path"
echo Set-cookie: csrftoken=\"$csrftoken\"
echo Set-cookie: sessionid=\"$sessionid\"