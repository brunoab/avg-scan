#!/bin/bash

#============================================#
# Config
#============================================#

log_file="./avg.log"
mail_to=""
mail_subject="AVG scan"
mail_header=""

#============================================#
# Processing
#============================================#

target=$1
avg_version=$(avgscan --version)
date_scan=$(date +"%a %b %d %H:%M:%S %Z %Y")

# start avg service
service avgd start 1>/dev/null

# refresh virus database
avgupdate --no-progress 1>/dev/null

# clean log file
echo "" > "$log_file"

# scan target
avgscan "$target" --report="$log_file" 1>/dev/null
retour_scan=$?

# Good to know
# ------------
# 0 no errors
# 1 test was interrupted by user
# 2 any error during test (e.g. cannot open file)
# 3 any warning during the scan
# 4 potentially unwanted program detected
# 5 virus detected
# 6 password-protected archives
# 7 file with hidden extension

report="$mail_header"$(cat "$log_file")

# if a threat is found
if [ "$retour_scan" -eq "2" -o "$retour_scan" -eq "3" -o "$retour_scan" -eq "4" -o "$retour_scan" -eq "5" ]
then
        # send scan log by mail
        printf "$report" | mail -s "$mail_subject" $mail_to
fi

#stop avg service
service avgd stop 1>/dev/null
