set -gx EDITOR nvim
set -gx TERMINAL kitty


# Essential paths
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path ~/.local/bin


starship init fish | source
zoxide init --cmd cd fish | source


# Lazy load everything else only when interactive
if status is-interactive

    # Lazy load zoxide
    function __lazy_zoxide
        functions -e __lazy_zoxide z
        zoxide init fish | source
    end
    function z; __lazy_zoxide; z $argv; end

    # Load aliases and functions on demand
    function __load_full_config
        functions -e __load_full_config
        source ~/.config/fish/conf.d/abbr.fish 2>/dev/null || true
        source ~/.config/fish/functions/_aliases.fish 2>/dev/null || true
    end

    # Auto-load full config after first prompt
    function fish_prompt --on-event fish_prompt
        functions -e fish_prompt
        __load_full_config &
        starship init fish | source
    end
end
