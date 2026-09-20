# ==============================================================================
# Fish Shell Configuration - Highly Optimized & Idiomatic
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Essential Environment Variables (Global & Exported)
# ------------------------------------------------------------------------------
set -gx HOME /Users/nick
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SHELL /opt/homebrew/bin/fish
set -gx CONFIG_DIR $HOME/.config
set -gx MANPAGER "less -X"
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx GOPATH $HOME/.go

# Homebrew environment
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx HOMEBREW_NO_DOWNLOADS_CONCURRENCY auto

# Java & Bun environments
if test -d /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home
    set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home
end
set -gx BUN_INSTALL $HOME/.bun

# Colored man pages via LESS_TERMCAP (native escape codes, 0 subshells)
set -gx LESS_TERMCAP_mb \e'[01;31m'
set -gx LESS_TERMCAP_md \e'[01;35m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[04;36m'

# ------------------------------------------------------------------------------
# 2. PATH Construction (Ordered, Validated & Deduplicated)
# ------------------------------------------------------------------------------
set -l candidate_paths \
    $HOME/nvim-macos-arm64/bin \
    $HOME/.local/share/mise/shims \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $HOME/.bun/bin \
    $HOME/.opencode/bin \
    $HOME/.grok/bin \
    $HOME/.docker/bin \
    $HOME/.orbstack/bin \
    /opt/homebrew/bin \
    /opt/homebrew/sbin \
    /opt/nanobrew/prefix/bin \
    $HOME/miniconda3/bin \
    $HOME/.local/xonsh-env/bin \
    (test -n "$JAVA_HOME"; and echo "$JAVA_HOME/bin") \
    $GOPATH/bin

set -l clean_path
for p in $candidate_paths $PATH
    if test -d "$p"; and not contains -- "$p" $clean_path
        set -a clean_path "$p"
    end
end
set -gx PATH $clean_path

# ------------------------------------------------------------------------------
# 3. Non-Interactive Guard (Bail early for scripts, subshells, & tools)
# ------------------------------------------------------------------------------
if not status is-interactive
    return
end

# Suppress fish greeting for clean startup
set -g fish_greeting ""

# ------------------------------------------------------------------------------
# 4. Interactive Tool Integrations (Cached for sub-millisecond startup)
# ------------------------------------------------------------------------------
set -l cache_dir $HOME/.cache/fish
test -d $cache_dir; or mkdir -p $cache_dir

function __load_cached_init -a name cmd bin_path -V cache_dir
    set -l cache_file "$cache_dir/$name.fish"
    if not test -f "$cache_file" -a -s "$cache_file"; or test "$bin_path" -nt "$cache_file"
        eval "$cmd" >"$cache_file"
    end
    source "$cache_file"
end

# Starship prompt (init script cached)
set -l starship_bin (command -v starship)
if test -n "$starship_bin"
    __load_cached_init starship "$starship_bin init fish --print-full-init" "$starship_bin"
end

# Zoxide cd replacement (init script cached)
set -l zoxide_bin (command -v zoxide)
if test -n "$zoxide_bin"
    __load_cached_init zoxide "$zoxide_bin init --cmd cd fish" "$zoxide_bin"
end

# FZF keybindings & fuzzy completion (init script cached)
set -l fzf_bin (command -v fzf)
if test -n "$fzf_bin"
    __load_cached_init fzf "$fzf_bin --fish" "$fzf_bin"
end

# Atuin shell history (init script cached)
set -l atuin_bin (command -v atuin)
if test -n "$atuin_bin"
    __load_cached_init atuin "$atuin_bin init fish" "$atuin_bin"
end

# Clean up helper
functions -e __load_cached_init

# OrbStack shell integration (if available)
if test -f "$HOME/.orbstack/shell/init2.fish"
    source "$HOME/.orbstack/shell/init2.fish" 2>/dev/null || true
end

# Otty shell integration (active only inside Otty terminal)
if test -n "$OTTY_SHELL_INTEGRATION" -a -r "$OTTY_SHELL_INTEGRATION/otty-integration.fish"
    source "$OTTY_SHELL_INTEGRATION/otty-integration.fish"
end

# ------------------------------------------------------------------------------
# 5. Key Bindings & Vi Mode
# ------------------------------------------------------------------------------
# Set vi mode as default key bindings and apply user bindings
set -g fish_key_bindings fish_vi_key_bindings
fish_vi_key_bindings
fish_user_key_bindings

# Quick history expansion: typing `sudo !!` expands inline
function __history_previous_command
    echo $history[1]
end
abbr -a !! --position anywhere --function __history_previous_command

# ------------------------------------------------------------------------------
# 6. FZF & Terminal Settings
# ------------------------------------------------------------------------------
set -gx FZF_DEFAULT_OPTS "
--height=50%
--layout=reverse
--border=none
--info=inline
--cycle
--ansi
--bind ctrl-j:down,ctrl-k:up
"

if command -q fd
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_ALT_C_COMMAND 'fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
end

set -gx fifc_editor nvim
set -gx EZA_COLORS "gm=33;1"

# ------------------------------------------------------------------------------
# 7. Navigation & Directory Shortcuts
# ------------------------------------------------------------------------------
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a ...... 'cd ../../../../..'
abbr -a md 'mkdir -p'
abbr -a rd 'rmdir -p'

# ------------------------------------------------------------------------------
# 8. Command Abbreviations & Aliases
# ------------------------------------------------------------------------------
abbr -a python python3
abbr -a pip pip3

# Safe file operations
alias cp 'cp -Ri'
alias mv 'mv -i'
alias rm 'rm -i'

# Colorized grep
alias grep 'grep --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'

# Modern eza listings (replaces ls)
if command -q eza
    alias l 'eza --long --all --header --git --icons --no-permissions --no-time --no-user --no-filesize --group-directories-first'
    alias ll 'eza -lagh --git --icons --no-user'
    alias la 'eza -lagh --git --icons --no-user --sort modified'
    alias cll 'clear; and eza --long --all --header --git --icons --no-permissions --no-time --no-user --no-filesize --group-directories-first'
    alias tree 'eza -Ta --icons --ignore-glob="node_modules|.git|.vscode|.DS_Store"'
    alias ltd 'eza -TaD --icons --ignore-glob="node_modules|.git|.vscode|.DS_Store"'
end

# Bat for cat
if command -q bat
    alias cat bat
end

# Dua for du (disk usage)
if command -q dua
    alias du dua
end

# Network shortcuts
alias ip "dig +short myip.opendns.com @resolver1.opendns.com"
alias ipl "ipconfig getifaddr en0"
alias ips "ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias sniff "sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump "sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E 'Host: .*|GET /.*'"
if command -q grc
    alias whois "grc whois"
end

# Utilities
alias wget 'wget -c'
alias hostfile 'eval sudo $EDITOR /etc/hosts'
