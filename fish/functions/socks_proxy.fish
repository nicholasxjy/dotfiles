function socks_proxy --description "Set SOCKS5 proxy" --argument-names host port
    set -q host[1]; or set host 127.0.0.1
    set -q port[1]; or set port 7890
    set -l url socks5://$host:$port

    set -Ux HTTP_PROXY $url
    set -Ux HTTPS_PROXY $url
    set -Ux ALL_PROXY $url
    set -Ux http_proxy $url
    set -Ux https_proxy $url
    set -Ux all_proxy $url

    if command -q git
        git config --global http.proxy $url
        git config --global https.proxy $url
    end

    echo "SOCKS5 proxy set to $url"
end
