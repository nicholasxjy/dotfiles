function fish_user_key_bindings
    # fzf-tab completion
    if command -q fzf; and functions -q __fzf_complete
        set -l tab_key \t
        set -q fzf_tab_key; and set tab_key $fzf_tab_key
        bind -M insert $tab_key __fzf_complete
        bind $tab_key __fzf_complete
    end

    # Atuin history search (both normal and insert modes)
    if functions -q _atuin_search
        bind ctrl-r _atuin_search
        bind -M insert ctrl-r _atuin_search
        bind up _atuin_bind_up
        bind -M insert up _atuin_bind_up
    end

    # FZF keybindings (both normal and insert modes)
    if functions -q fzf-file-widget
        bind ctrl-t fzf-file-widget
        bind -M insert ctrl-t fzf-file-widget
    end
    if functions -q fzf-cd-widget
        bind \ec fzf-cd-widget
        bind -M insert \ec fzf-cd-widget
    end
end
