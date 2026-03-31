#!/usr/bin/env -S bash -c "echo 'Do no run this script directly.'"

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  echo "$0 should not be executed directly."
  exit 1
fi

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Fix for "dubious ownership" git errors
export GIT_CONFIG_PARAMETERS="'safe.directory=*'"

APP_DIR="/opt/flutter"
SAVE_DIR="$XDG_CACHE_HOME/flutter_local"
MOUNT_DIR="$XDG_CACHE_HOME/flutter_sdk"

if [ ! -e "$APP_DIR" ]; then
  echo "/opt/flutter not found."
  return 1
fi

_unionfs() {
  if [ ! -e "$MOUNT_DIR/bin/flutter" ]; then
    mkdir -p "$SAVE_DIR"
    mkdir -p "$MOUNT_DIR"

    if ! unionfs -o cow -o umask=000 "$SAVE_DIR=RW:$APP_DIR=RO" "$MOUNT_DIR" > /dev/null 2>&1; then
      echo "unionfs failed"
      return 1
    fi
  fi
}

if whoami | grep -q -E 'builder|builduser|main-builder'; then
  export FLUTTER_ROOT="$APP_DIR"
elif grep -q flutter <<< $(groups); then
  export FLUTTER_ROOT="$APP_DIR"
elif _unionfs; then
  if [ -e "$MOUNT_DIR/bin" ]; then
    if ! grep -q "$MOUNT_DIR" <<< "$PATH"; then
      export FLUTTER_ROOT="$MOUNT_DIR"
    fi
  fi
fi

if ! grep -q "$FLUTTER_ROOT" <<< "$PATH"; then
  export PATH="$FLUTTER_ROOT/bin:$PATH"
fi
