function __fzf_complete
    set -l fzf_tab_buffer (commandline -b)
    set -l fzf_tab_token (commandline -ct)
    set -l fzf_tab_cursor (commandline -C)

    set -l fzf_tab_trimmed (string sub -s 1 -l $fzf_tab_cursor -- "$fzf_tab_buffer")

    set -l fzf_tab_dir (
        if type -q eza
            echo "eza -lah --git --icons --color=always"
        else
            echo "ls -lah"
        end
    )

    set -l fzf_tab_file (
        if type -q bat
            echo "bat --style=numbers --color=always --paging=never --wrap=never"
        else
            echo "cat"
        end
    )

    set -l fzf_tab_preview '
fish -c "
    set f {}
    if test -d \$f
        '"$fzf_tab_dir"' \$f
    else if test -f \$f
        '"$fzf_tab_file"' \$f
    else if test -e \$f
        '"$fzf_tab_dir"' \$f
    end
"
'

    set -l fzf_tab_fzf_flags \
        --query="$fzf_tab_token" \
        --height=~40% \
        --layout=reverse \
        --ansi \
        --preview="$fzf_tab_preview" \
        --preview-window=down:50%:wrap

    set -l fzf_tab_matches (complete --do-complete "$fzf_tab_trimmed")

    set -l fzf_tab_selected

    switch (count $fzf_tab_matches)
        case 0
            return
        case 1
            set fzf_tab_selected $fzf_tab_matches[1]
        case "*"
            set fzf_tab_selected (
		   printf '%s\n' $fzf_tab_matches |
		   fzf $fzf_tab_fzf_flags $fzf_complete_opts
		   )
    end

    set -l fzf_tab_completion (string split \t -- "$fzf_tab_selected")[1]

    #FIX:Path completion does not escape spaces
    if test -n "$fzf_tab_completion"
        commandline -t -- (string replace -a ' ' '\ ' -- "$fzf_tab_completion")
    end

    commandline -f repaint
end
