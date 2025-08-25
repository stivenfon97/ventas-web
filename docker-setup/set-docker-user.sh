#!/bin/bash
# This script detects the current Linux user and UID,
# then updates or adds APP_USER and APP_UID variables
# in the .env file for Docker configuration.
# This ensures Docker containers run with the same user as the host system,
# preventing file permission issues when editing files from the host.

APP_USER=$(whoami) && \
APP_UID=$(id -u) && \
sed -i "s/^APP_USER=.*/APP_USER=$APP_USER/" .env 2>/dev/null || echo "APP_USER=$APP_USER" >> .env && \
sed -i "s/^APP_UID=.*/APP_UID=$APP_UID  # user use in WSL/" .env 2>/dev/null || echo "APP_UID=$APP_UID" >> .env && \
echo "✅ APP_USER=$APP_USER y APP_UID=$APP_UID configurados en .env"