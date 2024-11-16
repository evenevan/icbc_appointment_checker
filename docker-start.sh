#!/bin/sh

# default schedule is every hour
CRON_SCHEDULE=${CRON_SCHEDULE:-"0 * * * *"}
COMMAND="python3 /app/icbc_roadtest_checker.py /app/config.yml > /proc/1/fd/1 2>/proc/1/fd/2"

echo "$CRON_SCHEDULE $COMMAND" > /etc/crontabs/root
# Set correct permissions for the crontab file
chmod 600 /etc/crontabs/root

exec crond -f -d 8