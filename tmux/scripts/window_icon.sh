#!/usr/bin/env bash

cmd="${1:-}"
cmd="${cmd##*/}"
cmd="${cmd,,}"

case "$cmd" in
  nvim|vim|vi|hx|helix)
    printf ''
    ;;
  zsh|bash|fish|sh)
    printf ''
    ;;
  tmux)
    printf ''
    ;;
  ssh)
    printf '󰣀'
    ;;
  git|lazygit)
    printf ''
    ;;
  python|python3|ipython)
    printf ''
    ;;
  node|nodejs|npm|yarn|pnpm|bun)
    printf ''
    ;;
  docker|docker-compose|lazydocker)
    printf ''
    ;;
  kubectl|k9s|helm)
    printf '☸'
    ;;
  go)
    printf ''
    ;;
  ruby|irb)
    printf ''
    ;;
  java)
    printf ''
    ;;
  rustc|cargo)
    printf ''
    ;;
  lua)
    printf ''
    ;;
  deno)
    printf '🦕'
    ;;
  mysql|psql|sqlite3)
    printf '󰆼'
    ;;
  *)
    printf ''
    ;;
esac
