AVG Scan
========

Bash script to scan for viruses on unix/linux server using AVG, a mail is sent if a virus is found.

Configuration
-------------

Open **avg-scan.sh** file and adjust configuration variables

Variable     | Example value  | Description
-------------|----------------|------------
mail_to      | you@test.com   | The mail adresse the scan log is sent to
mail_subject | AVG scan       | The mail subject
mail_header  | scan on monday | The mail body header
log_file     |./avg.log       | the name of the log file


Usage
-----

Make **avg-scan.sh** file executable, and run it:

```
chmod u+x avg-scan.sh
./avg-scan.sh <folder_or_file>
