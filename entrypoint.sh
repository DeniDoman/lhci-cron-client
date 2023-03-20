#!/bin/sh
set -e

# Assert env variable
if [ -z "$CONFIG_PATH" ]; then
  echo "ERROR: 'CONFIG_PATH' env variable is not defined"
  exit 1
fi

# Set default run frequency if the env variable is not set
CRON="${CRON:-@daily}"

# Provide env variables to the cron
env >> /etc/environment

# Add path and task to cron
echo PATH="$PATH" >> mycron
echo "$CRON /home/lhci/reports/lhci-client.sh >> /proc/1/fd/1" >> mycron
crontab mycron
rm mycron

# Run cron in foreground
cron -f
