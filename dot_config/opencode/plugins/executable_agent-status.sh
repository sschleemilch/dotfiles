#!/usr/bin/env bash
set -u

[ -z "${KITTY_WINDOW_ID:-}" ] && exit 0

case "${1:-done}" in
  working)
    BG="#c4a7e7"; FG="#191724" ;;
  needs-input|attention)
    BG="#f6c177"; FG="#191724" ;;
  done|idle|reset|*)
    BG="NONE"; FG="NONE" ;;
esac

kitten @ set-tab-color -m "window_id:${KITTY_WINDOW_ID}" \
  "active_bg=${BG}" "active_fg=${FG}" "inactive_bg=${BG}" "inactive_fg=${FG}" \
  >/dev/null 2>&1 || true

