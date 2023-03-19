#!/bin/sh
set -e

# Assert env variable
if [ -z "$CONFIG_PATH" ]; then
  echo "ERROR: 'CONFIG_PATH' env variable is not defined"
  exit 1
fi

# Set default run frequency if the env variable is not set
CRON="${CRON:-@daily}"

# Add task to cron
crontab -l | { cat; echo "$CRON /home/lhci/lhci-client.sh 2>&1"; } | crontab -

# Infinite wait
tail -f /dev/null
