#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
config_root="${XDG_CONFIG_HOME:-$HOME/.config}"
mirror_root="$repo_root/others"
targets=(waybar kitty dunst)

sync_target() {
  local target="$1"
  local source_dir="$config_root/$target"
  local mirror_dir="$mirror_root/$target"

  if [ ! -d "$source_dir" ]; then
    return 0
  fi

  mkdir -p "$mirror_dir"
  rsync -a --delete "$source_dir/" "$mirror_dir/"
}

sync_all() {
  local target

  for target in "${targets[@]}"; do
    sync_target "$target"
  done
}

watch_with_inotify() {
  local watch_paths=()
  local target

  for target in "${targets[@]}"; do
    if [ -d "$config_root/$target" ]; then
      watch_paths+=("$config_root/$target")
    fi
  done

  if [ "${#watch_paths[@]}" -eq 0 ]; then
    exit 0
  fi

  inotifywait \
    --monitor \
    --recursive \
    --event close_write,create,delete,move \
    --format '%w' \
    "${watch_paths[@]}" |
    while IFS= read -r changed_dir; do
      for target in "${targets[@]}"; do
        case "$changed_dir" in
          "$config_root/$target"/*|"$config_root/$target")
            sync_target "$target"
            break
            ;;
        esac
      done
    done
}

watch_with_polling() {
  while true; do
    sync_all
    sleep 5
  done
}

main() {
  sync_all

  case "${1:-watch}" in
    once)
      ;;
    watch)
      if command -v inotifywait >/dev/null 2>&1; then
        watch_with_inotify
      else
        watch_with_polling
      fi
      ;;
    *)
      printf 'Usage: %s [once|watch]\n' "${0##*/}" >&2
      exit 1
      ;;
  esac
}

main "$@"
