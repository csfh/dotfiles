#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link_file() {
  local source_path="$1"
  local target_path="$2"

  mkdir -p "$(dirname -- "$target_path")"

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    if [[ "$(readlink -- "$target_path" 2>/dev/null || true)" == "$source_path" ]]; then
      return
    fi

    mkdir -p "$backup_dir$(dirname -- "$target_path")"
    mv -- "$target_path" "$backup_dir$target_path"
  fi

  ln -s -- "$source_path" "$target_path"
}

link_file "$repo_dir/home/.bunfig.toml" "$HOME/.bunfig.toml"
link_file "$repo_dir/home/.npmrc" "$HOME/.npmrc"
link_file "$repo_dir/config/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$repo_dir/config/pnpm/config.yaml" "$HOME/.config/pnpm/config.yaml"
link_file "$repo_dir/config/Code/User/settings.json" "$HOME/.config/Code/User/settings.json"
