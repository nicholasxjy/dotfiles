function ssource --description '检查并重新加载 Fish 配置；--clear-cache 重建工具缓存'
    if test (count $argv) -gt 1; or begin
            set -q argv[1]; and test "$argv[1]" != --clear-cache
        end
        printf '用法：ssource [--clear-cache]\n' >&2
        return 2
    end

    set -l config "$__fish_config_dir/config.fish"
    set -l fish_bin (status fish-path)
    if not "$fish_bin" --no-config --no-execute "$config"
        printf '配置语法检查失败：%s\n' "$config" >&2
        return 1
    end
    if contains -- --clear-cache $argv
        for name in starship zoxide fzf atuin
            command rm -f -- "$HOME/.cache/fish/$name.fish"; or return 1
        end
    end
    if source "$config"
        printf 'Fish 配置已重新加载：%s\n' "$config"
    else
        printf 'Fish 配置加载失败，请检查上方错误。\n' >&2
        return 1
    end
end
