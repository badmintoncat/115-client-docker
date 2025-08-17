#!/bin/bash
# init-dbus.sh - Initialize D-Bus system

# Create D-Bus runtime directory
mkdir -p /var/run/dbus

# Start D-Bus system daemon
dbus-daemon --system --fork 2>/dev/null || true

echo "D-Bus initialization completed"
