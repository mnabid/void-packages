#!/bin/sh
appdir="/opt/HuionTablet"

export LD_LIBRARY_PATH="$appdir/libs"
export QT_QPA_PLATFORM_PLUGIN_PATH="$appdir/plugins"
export QML2_IMPORT_PATH="$appdir/qml"
export QT_QPA_PLATFORM=xcb

# Kill existing huionCore (daemon) and huiontablet (GUI) so we can restart cleanly.
# Do not kill ourselves if running as 'huiontablet'.
self=$$
for pid in $(pgrep -x huionCore 2>/dev/null); do
	kill "$pid" 2>/dev/null || true
done
for pid in $(pgrep -x huiontablet 2>/dev/null); do
	[ "$pid" != "$self" ] && kill "$pid" 2>/dev/null || true
done

LOG_DIR="${HUION_LOG_DIR:-$HOME/.local/share/huiontablet}"
mkdir -p "$LOG_DIR"

if [ "$1" = "autostart" ]; then
	sleep 8
fi

# Run huionCore in background
"$appdir/huionCore" -d >>"$LOG_DIR/huionCore.log" 2>&1 &

if [ "$1" = "manual_launch" ]; then
	sleep 2
fi

# Run huiontablet GUI
exec "$appdir/huiontablet" "$@" -d >>"$LOG_DIR/huiontablet.log" 2>&1
