#!/bin/sh
set -e

# Configure WireGuard interface
WG_CONF="/etc/wireguard/wg0.conf"
PRIVATE_KEY="/etc/wireguard/privatekey"

# Function to gracefully stop WireGuard
stop() {
    echo "Stopping WireGuard..."
    wg-quick down wg0
    exit 0
}

# Trap signals
trap stop SIGTERM SIGINT SIGQUIT

# Start WireGuard
if [ -f "$WG_CONF" ]; then
    echo "Starting WireGuard..."
    wg-quick up "$WG_CONF"
else
    echo "Error: WireGuard configuration file not found at $WG_CONF"
    exit 1
fi

# Display public key
if [ -f "$PRIVATE_KEY" ]; then
    echo "Public key: $(wg pubkey < "$PRIVATE_KEY")"
else
    echo "Warning: Private key file not found at $PRIVATE_KEY"
fi

# Start tcpdump
echo "Starting tcpdump..."
exec tcpdump -ttttni wg0