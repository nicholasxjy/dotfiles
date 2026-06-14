function killprocess --description 'Kill processes selected from ps output'
    set -l pids (ps aux | fzf -m --header-lines=1 | awk '{print $2}')

    if test (count $pids) -gt 0
        echo "Killing processes: $pids"
        kill -9 $pids
    end
end


function killport --description 'Select listening ports to kill'
    set -l pids (lsof -nP -iTCP -sTCP:LISTEN | awk 'NR > 1 {print $2, $9, substr($0, index($0,$1))}' | sort -u | \
        fzf -m --exact --tac --preview 'pstree -p (echo {} | awk "{print \\$1}")' --preview-window=down,30% --header 'Select processes to kill (PID Port Command):' | \
        awk '{print $1}' | sort -u)

    if test (count $pids) -gt 0
        kill -9 $pids
    end
end


function sudo!!
    eval sudo $history[1]
end


function __set_proxy_env --argument-names url
    set -Ux HTTP_PROXY $url
    set -Ux HTTPS_PROXY $url
    set -Ux ALL_PROXY $url
    set -Ux http_proxy $url
    set -Ux https_proxy $url
    set -Ux all_proxy $url
end

function __set_node_proxy --argument-names url
    if command -q npm
        npm config set proxy $url
        npm config set https-proxy $url
    end

    if command -q yarn
        yarn config set proxy $url
        yarn config set https-proxy $url
    end
end

function __set_git_proxy --argument-names url
    if command -q git
        git config --global http.proxy $url
        git config --global https.proxy $url
    end
end

function proxy --description "Set http proxy" --argument-names host port
    set -q host[1]; or set host 127.0.0.1
    set -q port[1]; or set port 7890
    set -l url http://$host:$port

    __set_proxy_env $url
    __set_node_proxy $url
    __set_git_proxy $url

    echo "HTTP proxy set to $url"
end

function socks_proxy --description "Set socks5 proxy" --argument-names host port
    set -q host[1]; or set host 127.0.0.1
    set -q port[1]; or set port 7890
    set -l url socks5://$host:$port

    __set_proxy_env $url
    __set_git_proxy $url

    echo "SOCKS5 proxy set to $url"
end

function noproxy --description "Unset all proxy variables"
    set -e HTTP_PROXY HTTPS_PROXY ALL_PROXY http_proxy https_proxy all_proxy

    if command -q npm
        npm config delete proxy
        npm config delete https-proxy
    end

    if command -q yarn
        yarn config delete proxy
        yarn config delete https-proxy
    end

    if command -q git
        git config --global --unset http.proxy
        git config --global --unset https.proxy
    end

    echo "Proxy unset"
end


function zd --description "zoxide better cd"
    set -l dir (zoxide query -l | fzf \
        --bind 'ctrl-j:down' \
        --bind 'ctrl-k:up' \
        --prompt="zoxide> " \
        --no-preview)

    if test -n "$dir"
        cd "$dir"
    end
end
