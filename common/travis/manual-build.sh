#!/bin/bash
#
# manual-build.sh
#

TARGET_ARCH="$1"
RUN_TEST="$2"
PACKAGES_INPUT="$3"

# Determine host architecture based on target libc/arch
HOST_ARCH="x86_64"
[[ "$TARGET_ARCH" == *"-musl" ]] && HOST_ARCH="x86_64-musl"
if [[ "$TARGET_ARCH" == "i686" || "$TARGET_ARCH" == "i686-musl" ]]; then
	HOST_ARCH="$TARGET_ARCH"
fi

TEST_FLAG=""
[ "$RUN_TEST" = "true" ] && TEST_FLAG="-Q"

ARCH_FLAG=""
[ "$HOST_ARCH" != "$TARGET_ARCH" ] && ARCH_FLAG="-a $TARGET_ARCH"

echo "Building for target $TARGET_ARCH on host $HOST_ARCH"

IFS=';' read -ra PKG_LIST <<< "$PACKAGES_INPUT"
for entry in "${PKG_LIST[@]}"; do
	entry=$(echo "$entry" | xargs)
	[ -z "$entry" ] && continue

	pkg=$(echo "$entry" | awk '{print $1}')
	opts=$(echo "$entry" | cut -d' ' -f2-)
	[ "$opts" = "$pkg" ] && opts=""

	if [ ! -d "srcpkgs/$pkg" ]; then
		echo "Package directory srcpkgs/$pkg not found, skipping."
		continue
	fi

	args="-j$(nproc) -E $ARCH_FLAG $TEST_FLAG"
	[ -n "$opts" ] && args="$args -o $opts"

	echo "::group::Building $pkg"
	./xbps-src $args pkg "$pkg" || exit
	echo "::endgroup::"
done
