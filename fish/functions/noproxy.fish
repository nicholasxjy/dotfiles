function noproxy --description "Unset all proxy variables"
    set -e HTTP_PROXY HTTPS_PROXY ALL_PROXY http_proxy https_proxy all_proxy
    set -Ue HTTP_PROXY HTTPS_PROXY ALL_PROXY http_proxy https_proxy all_proxy 2>/dev/null

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
