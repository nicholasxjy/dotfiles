function ssource --description "Reload fish configuration and clean cache"
    # Invalidate tool init caches if any
    set -l cache_dir $HOME/.cache/fish
    rm -f $cache_dir/*.fish 2>/dev/null

    source $__fish_config_dir/config.fish
    echo "Fish configuration reloaded."
end
