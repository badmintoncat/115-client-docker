#!/bin/sh

if [ ! -d '/Downloads' ]
then
    mkdir -p '/Downloads'
    chmod a+w '/Downloads'
else
    echo "Path /Downloads folder is Ready!"
fi

# Start D-Bus if not running (fix for bus connection errors)
if ! pgrep -x "dbus-daemon" > /dev/null; then
    dbus-daemon --session --fork 2>/dev/null || true
fi

# Change to app directory to help with relative library paths
cd /usr/local/115Browser 2>/dev/null || cd /

# Set timezone to US Eastern (New York)
export TZ=America/New_York

# Set Chinese language but keep US Eastern time settings
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export LANGUAGE=zh_CN:zh
export LC_CTYPE=zh_CN.UTF-8
export LC_NUMERIC=zh_CN.UTF-8
export LC_TIME=en_US.UTF-8          # US time format
export LC_COLLATE=zh_CN.UTF-8
export LC_MONETARY=zh_CN.UTF-8
export LC_MESSAGES=zh_CN.UTF-8
export LC_PAPER=zh_CN.UTF-8
export LC_NAME=zh_CN.UTF-8
export LC_ADDRESS=zh_CN.UTF-8
export LC_TELEPHONE=zh_CN.UTF-8
export LC_MEASUREMENT=zh_CN.UTF-8
export LC_IDENTIFICATION=zh_CN.UTF-8

# Refresh font cache
fc-cache -fv 2>/dev/null || true
# clean cache
rm -rf /config/xdg
echo "Cache cleaned up..."

# Add more flags to handle container environment issues
exec /usr/local/115Browser/115Browser \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-software-rasterizer \
    --disable-features=VizDisplayCompositor \
    --force-device-scale-factor=1
