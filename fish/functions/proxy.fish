function proxy --description 'Set proxy environment variables'
  set -gx HTTP_PROXY "http://127.0.0.1:7890"
  set -gx HTTPS_PROXY "http://127.0.0.1:7890"
  set -gx FTP_PROXY "http://127.0.0.1:7890"
  set -gx ALL_PROXY "http://127.0.0.1:7890"
end


