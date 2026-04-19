#!/bin/sh

BOARD_DIR="$(dirname "$0")"

install -m 0644 -D "$BOARD_DIR"/extlinux.conf "$TARGET_DIR"/boot/extlinux/extlinux.conf

grep -qE '^\s*Include\s+/etc/ssh/sshd_config\.d/\*\.conf' "$TARGET_DIR"/etc/ssh/sshd_config || \
	sed -i '1i Include /etc/ssh/sshd_config.d/*.conf' "$TARGET_DIR"/etc/ssh/sshd_config
