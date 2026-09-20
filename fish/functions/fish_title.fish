function fish_title
    set -l cmd $argv[1]
    set -l shell (path basename (status fish-path))

    if test -n "$cmd"
        echo "$shell | $cmd "(prompt_pwd)
    else
        echo "$shell | "(prompt_pwd)
    end
end
