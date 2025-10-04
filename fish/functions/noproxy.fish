
function noproxy --description 'Unset proxy environment variables'
  set -e HTTP_PROXY
  set -e HTTPS_PROXY
  set -e FTP_PROXY
  set -e ALL_PROXY
end
