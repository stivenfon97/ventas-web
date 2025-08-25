#!/bin/bash

# Validate vars
if [ -z "$APP_USER" ] || [ -z "$APP_UID" ]; then
  echo "⚠️  ERROR: enviroment vars are not defined: APP_USER or APP_UID."
  exit 1
fi

# create user if don't exists
if ! id "$APP_USER" &>/dev/null; then
  useradd -m -u "$APP_UID" "$APP_USER"
fi

# correct premissions
if [ "$(stat -c %u /var/www/html)" != "$APP_UID" ]; then
  chown -R "$APP_UID:$APP_UID" /var/www/html
fi

chown -R $APP_UID:$APP_UID /var/www/html/storage /var/www/html/bootstrap/cache

set -e

# Install node dependecies if necessary
cd /var/www/html/

rm -rf node_modules/

if [ ! -d "node_modules" ]; then
  echo "📦 Installing Node dependencies..."
  npm install --legacy-peer-deps
fi
 
# start Vite in background
echo "🚀 Starting Vite (npm run dev)..."
npm run dev -- --host 0.0.0.0 &

# Ejecute
exec "$@"