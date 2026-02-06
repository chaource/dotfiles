#!/bin/bash
set -euo pipefail

input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // "unknown"')
cwd=$(echo "$input" | jq -r '.cwd // "unknown"')
dir=$(basename "$cwd")

detail=""
urgency="normal"

danger_patterns=""
# file destruction
danger_patterns+="rm -[rf]|rm --force|rm --recursive|rmdir|shred|unlink"
# git destructive
danger_patterns+="|git reset --hard|git push (-f|--force)|git checkout \."
danger_patterns+="|git restore \.|git clean|git branch -D"
danger_patterns+="|git stash (drop|clear)|git rebase"
# database
danger_patterns+="|\b(drop|truncate|delete from)\b"
# kubernetes
danger_patterns+="|kubectl delete|kubectl drain|kubectl cordon"
danger_patterns+="|kubectl replace --force|kubectl scale.*replicas.*0"
danger_patterns+="|helm (uninstall|delete)"
# docker
danger_patterns+="|docker (rm|rmi|stop|kill)"
danger_patterns+="|docker (system|volume|container|image|network) (prune|rm)"
danger_patterns+="|docker-compose down -v"
# process/system
danger_patterns+="|killall|pkill|kill -9"
danger_patterns+="|chmod -R|chown -R"
danger_patterns+="|dd if=|mkfs|fdisk|parted"
danger_patterns+="|systemctl (stop|disable|mask|restart)"
danger_patterns+="|reboot|shutdown|poweroff"
# package removal
danger_patterns+="|pacman -R|apt (remove|purge|autoremove)|pip uninstall"
# pipe to shell
danger_patterns+="|curl.*\| *(sh|bash)|wget.*\| *(sh|bash)"
# sync with delete
danger_patterns+="|rsync.*--delete"
# infra
danger_patterns+="|terraform (destroy|apply)|pulumi destroy"

case "$tool" in
  Bash)
    cmd=$(echo "$input" | jq -r '.tool_input.command // empty')
    [ -n "$cmd" ] && detail=$(echo "$cmd" | head -c 80)
    if echo "$cmd" | grep -qiE "($danger_patterns)"; then
      urgency="critical"
    fi
    ;;
  Edit|Write|Read)
    path=$(echo "$input" | jq -r '.tool_input.file_path // empty')
    [ -n "$path" ] && detail=$(basename "$path")
    ;;
esac

body="approve $tool"
[ -n "$detail" ] && body="$body: $detail"

action=$(notify-send --app-name=claude --urgency="$urgency" -t 15000 \
  --action=approve=Approve \
  "claude [$dir]" "$body" 2>/dev/null || true)

if [ "$action" = "approve" ]; then
  printf '{"hookSpecificOutput":{"hookEventName":"PermissionRequest","decision":{"behavior":"allow"}}}'
fi
exit 0
