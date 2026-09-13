#!/usr/bin/env bash
#
# Daily updater. Every step prints a start banner and an end banner carrying its
# exit status and duration, so a run can be read top-to-bottom and any single
# failure is visible without scrolling through tool output.
#
# A failing step does not abort the run: it is reported, the remaining steps
# still execute, and the script exits non-zero if anything failed.

set -uo pipefail

# Unattended updates: use supported non-interactive modes and never wait for
# stdin. Missing credentials or privileges should fail a step, not prompt.
export HOMEBREW_NO_ASK=1
export CODEX_NON_INTERACTIVE=1
export GIT_TERMINAL_PROMPT=0
export npm_config_yes=true
export SUDO_ASKPASS=/usr/bin/false
exec </dev/null

# Resolve paths independently of the caller's working directory.
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd) || exit 1
cd -- "$SCRIPT_DIR" || exit 1

WORK_DIR=$(mktemp -d "${TMPDIR:-/tmp}/daily-update.XXXXXX") || exit 1
trap 'rm -rf -- "$WORK_DIR"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

if [ -t 1 ]; then
  C_RESET=$'\033[0m'
  C_DIM=$'\033[2m'
  C_STEP=$'\033[1;36m'
  C_OK=$'\033[1;32m'
  C_ERR=$'\033[1;31m'
else
  C_RESET=''
  C_DIM=''
  C_STEP=''
  C_OK=''
  C_ERR=''
fi

RULE=$(printf '─%.0s' {1..68})
TOTAL=0
FAILED=0
SUMMARY=()

step() {
  local name="$1" fn="$2"
  TOTAL=$((TOTAL + 1))

  printf '\n%s%s%s\n' "$C_DIM" "$RULE" "$C_RESET"
  printf '%s▶ %s%s\n' "$C_STEP" "$name" "$C_RESET"
  printf '%s  %s() · start %s%s\n' "$C_DIM" "$fn" "$(date '+%H:%M:%S')" "$C_RESET"
  printf '%s%s%s\n' "$C_DIM" "$RULE" "$C_RESET"

  local begin=$SECONDS rc=0
  "$fn" || rc=$?
  local secs=$((SECONDS - begin))

  printf '%s%s%s\n' "$C_DIM" "$RULE" "$C_RESET"
  if [ "$rc" -eq 0 ]; then
    printf '%s◀ %s — %s✔ ok%s %s(%ss)%s\n' \
      "$C_STEP" "$name" "$C_OK" "$C_RESET" "$C_DIM" "$secs" "$C_RESET"
    SUMMARY+=("${C_OK}✔${C_RESET} $name ${C_DIM}(${secs}s)${C_RESET}")
  else
    FAILED=$((FAILED + 1))
    printf '%s◀ %s — %s✘ failed (exit %s)%s %s(%ss)%s\n' \
      "$C_STEP" "$name" "$C_ERR" "$rc" "$C_RESET" "$C_DIM" "$secs" "$C_RESET"
    SUMMARY+=("${C_ERR}✘${C_RESET} $name ${C_DIM}(exit $rc, ${secs}s)${C_RESET}")
  fi
}

do_homebrew() {
  brew upgrade --yes
}

download() {
  curl -fSL --retry 3 --retry-delay 2 --connect-timeout 15 --max-time 300 \
    -o "$2" "$1"
}

do_neovim() {
  local url="https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz"
  local file="$WORK_DIR/nvim-macos-arm64.tar.gz"
  local dir="nvim-macos-arm64"

  echo "==> Downloading Neovim nightly..."
  download "$url" "$file" || return $?

  # Reject incomplete or invalid archives before touching the installation.
  tar tzf "$file" >/dev/null || return $?

  echo "==> Removing macOS quarantine attribute..."
  xattr -c "$file" || true

  echo "==> Extracting..."
  tar xzf "$file" -C "$SCRIPT_DIR" || return $?

  echo "==> Removing downloaded archive..."
  rm -f "$file" || return $?

  "$SCRIPT_DIR/$dir/bin/nvim" --version || return $?
  echo "Binary path: $SCRIPT_DIR/$dir/bin/nvim"
}

do_codex() {
  # Download first, then run: `curl ... | sh` under pipefail reports a false
  # failure when curl is killed by SIGPIPE as the installer exits.
  local script="$WORK_DIR/codex-install.sh"
  download https://chatgpt.com/codex/install.sh "$script" || return $?
  sh "$script"
}

do_ocx() {
  # The updater manages stopping and restoring its own running proxy.
  ocx update
}

do_pi() {
  pi update
}

do_pi_extensions() {
  pi update --extensions
}

do_grok() {
  grok update
}

printf '\n%s%s%s\n' "$C_STEP" "Daily update — $(date '+%Y-%m-%d %H:%M:%S')" "$C_RESET"

step "Homebrew"    do_homebrew
step "Neovim"      do_neovim
step "Codex CLI"   do_codex
step "ocx"         do_ocx
step "pi"          do_pi
step "pi extensions" do_pi_extensions
step "grok"        do_grok

printf '\n%s%s%s\n' "$C_DIM" "$RULE" "$C_RESET"
printf '%sSummary%s %s%d steps · %d failed%s\n' \
  "$C_STEP" "$C_RESET" "$C_DIM" "$TOTAL" "$FAILED" "$C_RESET"
for line in "${SUMMARY[@]}"; do
  printf '  %s\n' "$line"
done
printf '%s%s%s\n' "$C_DIM" "$RULE" "$C_RESET"

[ "$FAILED" -eq 0 ]
