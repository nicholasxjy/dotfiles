# Bindings are applied after tool initialization by fish_user_key_bindings.
if status is-interactive
    set -q fzf_tab_key; or set -g fzf_tab_key \t
end
