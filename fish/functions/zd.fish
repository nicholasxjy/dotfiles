function zd --description "zoxide interactive cd via fzf"
    if not command -q zoxide; or not command -q fzf
        echo "zd: Requires zoxide and fzf" >&2
        return 1
    end

    set -l dir (zoxide query -l | fzf \
        --bind 'ctrl-j:down,ctrl-k:up' \
        --prompt="zoxide> " \
        --no-preview)

    if test -n "$dir"
        cd "$dir"
    end
end
