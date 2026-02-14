#!/bin/bash
input=$(cat)

(
  reason=$(echo "$input" | jq -r '.stop_reason // "unknown"')
  cwd=$(echo "$input" | jq -r '.cwd // "unknown"')
  dir=$(basename "$cwd")

  case "$reason" in
    end_turn)       msg="task completed" ;;
    max_turns)      msg="reached max turns" ;;
    stop_button)    msg="stopped by user" ;;
    *)              msg="stopped: $reason" ;;
  esac

  win_id=""
  if command -v xdotool &>/dev/null && command -v tmux &>/dev/null; then
    session=$(tmux display-message -p '#{session_name}' 2>/dev/null) || true
    if [[ -n "$session" ]]; then
      client_tty=$(tmux list-clients -F '#{client_tty} #{session_name}' 2>/dev/null | grep " ${session}$" | awk '{print $1}')
      if [[ -n "$client_tty" ]]; then
        tty_name="${client_tty#/dev/}"
        terminal_pid=$(ps -t "$tty_name" -o ppid= 2>/dev/null | head -1 | tr -d ' ')
        [[ -n "$terminal_pid" ]] && win_id=$(xdotool search --pid "$terminal_pid" 2>/dev/null | head -1)
      fi
    fi
  fi

  if [[ -n "$win_id" ]]; then
    action=$(notify-send --app-name=claude --urgency=low \
      -A default=Focus \
      "claude [$dir]" "$msg" 2>/dev/null || true)
    [[ "$action" == "default" ]] && xdotool windowactivate "$win_id" 2>/dev/null || true
  else
    notify-send --app-name=claude --urgency=low "claude [$dir]" "$msg" 2>/dev/null || true
  fi
) </dev/null &>/dev/null &
disown
exit 0
