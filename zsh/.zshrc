alias la="ls -la --color=auto"
alias ll="ls -l --color=auto"
alias locrs="find . -name '*.rs' | xargs wc -l | tail -n1"

eval "$(starship init zsh)"
