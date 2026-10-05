function fish_prompt --description '目录、Git、退出状态、耗时和代理提示'
    set -l previous_status $status
    set -l previous_pipeline $pipestatus
    set -l normal (set_color normal)
    set -l user_color bcc313
    set -l cwd_color 2a9c89
    set -l status_color dc483b
    set -q fish_color_user; and set user_color $fish_color_user
    set -q fish_color_cwd; and set cwd_color $fish_color_cwd
    set -q fish_color_status; and set status_color $fish_color_status

    printf '\n%s%s@%s %s%s%s' (set_color $user_color) $USER (prompt_hostname) \
        (set_color $cwd_color) (prompt_pwd) "$normal"
    fish_git_prompt
    if set -q HTTPS_PROXY; or set -q https_proxy; or set -q ALL_PROXY; or set -q all_proxy
        printf ' %s代理%s' (set_color cyan) "$normal"
    end
    if test "$previous_status" -ne 0
        printf ' %s退出 %s [%s]%s' (set_color $status_color) "$previous_status" \
            (string join '|' $previous_pipeline) "$normal"
    end
    if set -q CMD_DURATION; and test "$CMD_DURATION" -ge 2000
        printf ' 耗时 %.1fs' (math "$CMD_DURATION / 1000")
    end
    printf ' %s%s%s\n' (set_color brblack) (date '+%H:%M:%S') "$normal"
    if fish_is_root_user
        printf '%s# %s' (set_color red) "$normal"
    else
        printf '%s❯ %s' (set_color $cwd_color) "$normal"
    end
end
