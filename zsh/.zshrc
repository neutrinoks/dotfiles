# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

alias la="ls -la --color=auto"
alias ll="ls -l --color=auto"
alias locrs="find . -name '*.rs' | xargs wc -l | tail -n1"
gitupdate() { git reset --hard "$(git log -n 2 --pretty=format:'%H' | tail -1)" && git pull }

if [ -z "$SSH_AGENT_PID" ] || ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
fi

export NVM_DIR="$HOME/.nvm"

_nvm_load() {
    unfunction nvm node npm npx 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

nvm()  { _nvm_load; nvm "$@" }
node() { _nvm_load; node "$@" }
npm()  { _nvm_load; npm "$@" }
npx()  { _nvm_load; npx "$@" }
