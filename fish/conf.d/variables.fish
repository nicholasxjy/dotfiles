# set XDG Base Directory Specification - there could be a better way to do this
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share

set -gx EZA_CONFIG_DIR $HOME/.config/eza

# Opan MAN pages in Neovim
set -gx MANPAGER "nvim +Man!"

string match -q "$TERM_PROGRAM" nvim
and . (nvim --locate-shell-integration-path fish)

set -gx EDITOR nvim

