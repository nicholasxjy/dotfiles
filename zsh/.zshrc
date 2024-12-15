# Download Znap, if it's not there yet.
[[ -r ~/.config/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.config/znap
source ~/.config/znap/znap.zsh  # Start Znap


# `znap prompt` makes your prompt visible in just 15-40ms!
# znap prompt sindresorhus/pure

# `znap source` starts plugins.
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

# The cache gets regenerated, too, when the eval command has changed. For
# example, here we include a variable. So, the cache gets invalidated whenever
# this variable has changed.
znap source marlonrichert/zcolors

export EDITOR="vim"
export SHELL="/bin/zsh"

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# The same goes for any other kind of custom prompt:
znap eval starship 'starship init zsh --print-full-init'
znap prompt

eval "$(zoxide init zsh --cmd cd)"
# eval "$(starship init zsh)"

# Open in tmux popup if on tmux, otherwise use --height mode
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border sharp'

# FZF Plugin
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
# --highlight-line \
# --info=inline-right \
# --ansi \
# --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
# --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
# --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
# --color=selected-bg:#494d64 \
# --multi"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# pnpm
export PNPM_HOME="/Users/nick/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# rust 
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

[ -f ~/.config/zsh/*.zsh ] && source ~/.config/zsh/*.zsh


export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
eval "$(atuin init zsh)"
source "$HOME/.rye/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

. /opt/homebrew/opt/asdf/libexec/asdf.sh
