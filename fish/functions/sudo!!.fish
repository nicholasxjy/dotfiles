function sudo!! --description "Run the previous command with sudo"
    eval sudo $history[1]
end
