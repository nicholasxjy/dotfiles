function gw --description "Switch git worktrees via fzf"
    if not command -q git; or not command -q fzf
        echo "gw: Requires git and fzf" >&2
        return 1
    end

    if not command git rev-parse --git-dir >/dev/null 2>&1
        echo "gw: Not inside a git repository" >&2
        return 1
    end

    set -l paths
    for entry in (command git worktree list --porcelain -z | string split0)
        set -l fields (string split --max 1 ' ' -- "$entry")
        if test "$fields[1]" = worktree
            set -a paths "$fields[2]"
        end
    end
    test (count $paths) -gt 0; or return 1

    set -l dir (printf '%s\0' $paths | fzf \
        --read0 --print0 --no-multi \
        --bind 'ctrl-j:down,ctrl-k:up' \
        --prompt="worktree> " \
        --no-preview | string split0)

    if test (count $dir) -eq 1
        cd -- "$dir"
    end
end
