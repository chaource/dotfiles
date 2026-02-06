#!/bin/bash
set -euo pipefail

input=$(cat)
reason=$(echo "$input" | jq -r '.stop_reason // "unknown"')
cwd=$(echo "$input" | jq -r '.cwd // "unknown"')
dir=$(basename "$cwd")

case "$reason" in
  end_turn)       msg="task completed" ;;
  max_turns)      msg="reached max turns" ;;
  stop_button)    msg="stopped by user" ;;
  *)              msg="stopped: $reason" ;;
esac

notify-send --urgency=low "claude [$dir]" "$msg"
exit 0
