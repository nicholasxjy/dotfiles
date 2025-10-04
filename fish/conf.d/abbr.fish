if status is-interactive
    abbr --add bic --set-cursor 'brew install % --cask'
    abbr --add cl clear
    abbr --add cat 'bat -pp'
    # Editors & Terminals
    abbr --add vim nvim
    abbr --add config '~/.config/'
    abbr --add siz 'du -khsc'
    abbr --add spp 'speedtest -u Gbps'
    abbr --add usebash 'chsh -s $(which bash)'
    abbr --add usezsh 'chsh -s $(which zsh)'
    abbr --add yy yazi
    abbr --add zip 'ouch compress -q'
    abbr --add unzip ouch decompress
    abbr --add lzip ouch list
end
