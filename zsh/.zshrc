# Let gpg's pinentry know which terminal to prompt on
export GPG_TTY=$(tty)

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

# Line-editing keys on macOS as manjaro-zsh-config binds them on Linux: the
# terminal sends Home/End, Ctrl+arrows and the like as escape sequences that
# zsh alone leaves unbound.
if [[ "$OSTYPE" == darwin* ]]; then
  bindkey -e
  bindkey '^[[H' beginning-of-line
  bindkey '^[[1~' beginning-of-line
  bindkey '^[[F' end-of-line
  bindkey '^[[4~' end-of-line
  bindkey '^[[3~' delete-char
  bindkey '^[[1;5D' backward-word
  bindkey '^[[1;5C' forward-word
  bindkey '^H' backward-kill-word
  bindkey '^[[3;5~' kill-word
  bindkey '^[[5~' history-beginning-search-backward
  bindkey '^[[6~' history-beginning-search-forward
  bindkey '^[[Z' undo
fi

# Starship prompt on macOS only -- Linux keeps the manjaro prompt sourced above.
# Must come after it, otherwise the manjaro prompt would win.
if [[ "$OSTYPE" == darwin* ]] && command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

alias la="ls -la --color=auto"
alias ll="ls -l --color=auto"
alias locrs="find . -name '*.rs' | xargs wc -l | tail -n1"
gitupdate() { git reset --hard "$(git log -n 2 --pretty=format:'%H' | tail -1)" && git pull }

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

# Auto-switch to a project's .nvmrc on cd, without paying nvm.sh's
# sourcing cost on every new shell: walk up from $PWD for .nvmrc first
# (cheap, no nvm needed) and only trigger _nvm_load if one is actually
# found. Mirrors nvm's own "automatically call nvm use" recipe.
autoload -U add-zsh-hook

_load_nvmrc() {
  local dir="$PWD"
  while [ "$dir" != "/" ] && [ ! -f "$dir/.nvmrc" ]; do
    dir="$(dirname "$dir")"
  done
  [ -f "$dir/.nvmrc" ] || return

  if ! typeset -f nvm_find_nvmrc >/dev/null 2>&1; then
    _nvm_load
  fi

  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc 2>/dev/null)"
  [ -n "$nvmrc_path" ] || return

  local nvmrc_node_version
  nvmrc_node_version="$(nvm version "$(cat "$nvmrc_path")" 2>/dev/null)"

  # No automatic `nvm install`: entering an untrusted repo must not trigger downloads.
  if [ "$nvmrc_node_version" = "N/A" ]; then
    echo "nvm: version from $nvmrc_path not installed, run 'nvm install'" >&2
  elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
    nvm use
  fi
}
add-zsh-hook chpwd _load_nvmrc
_load_nvmrc

# Android SDK (adb, emulator, sdkmanager)
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

# ~/bin muss vor ~/.local/bin stehen: /etc/profile.d/home-local-bin.sh laeuft nach
# .zshenv und schiebt ~/.local/bin nach vorne, sonst greift der claude-Wrapper nicht.
path=("$HOME/bin" ${path:#$HOME/bin})
export PATH

# SSH keys are served by the 1Password SSH agent (socket path differs per OS)
if [[ "$OSTYPE" == darwin* ]]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
else
  export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi

# Machine-specific settings that stay out of the public repo
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
