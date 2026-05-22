#!/bin/bash

# Substitute XDG_CONFIG_HOME by ~/.config if the env var is unset or empty
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}

# Allow users to override command-line options
if [[ -f "${XDG_CONFIG_HOME}/antigravity-ide-flags.conf" ]]; then
    mapfile -t USER_FLAGS <<< "$(grep -v '^#' "${XDG_CONFIG_HOME}/antigravity-ide-flags.conf")"
    echo "User flags:" "${USER_FLAGS[@]}"
fi

# Launch Antigravity IDE with the given flags
exec /opt/antigravity-ide/antigravity-ide "${USER_FLAGS[@]}" "$@"
