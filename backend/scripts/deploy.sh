#!/bin/bash

set -e

APP_DIR="/var/www/FastGrowth-Business-WebApp"
BACKEND_DIR="$APP_DIR/backend"

echo ""
echo "==========================================="
echo "🚀 FastGrowth Deployment Started"
echo "==========================================="

echo ""
echo "📂 Changing to application directory..."
cd "$APP_DIR"

echo ""
echo "📥 Fetching latest code..."
git fetch origin

echo ""
echo "🔄 Resetting to latest main branch..."
git reset --hard origin/main

echo ""
echo "📂 Switching to backend..."
cd "$BACKEND_DIR"

echo ""
echo "📦 Installing dependencies..."
npm ci

echo ""
echo "🔄 Reloading PM2..."
pm2 reload ecosystem.config.js --env production

echo ""
echo "⏳ Waiting for application..."
sleep 3

echo ""
echo "🏥 Running health check..."
curl -f http://localhost/health

echo ""
echo "📋 PM2 Status"
pm2 status

echo ""
echo "==========================================="
echo "✅ Deployment Successful. Hurray!"
echo "==========================================="
