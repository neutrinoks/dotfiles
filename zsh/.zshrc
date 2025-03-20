alias la="ls -la"
alias ll="ls -l"
alias locrs="find . -name '*.rs' | xargs wc -l | tail -n1"

eval "$(starship init zsh)"
