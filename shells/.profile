export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=es_AR.UTF-8
export LC_TIME=es_AR.UTF-8
export LC_MONETARY=es_AR.UTF-8
export LC_PAPER=es_AR.UTF-8
export LC_MEASUREMENT=es_AR.UTF-8
export LC_NAME=es_AR.UTF-8
export LC_ADDRESS=es_AR.UTF-8
export LC_TELEPHONE=es_AR.UTF-8
export LC_IDENTIFICATION=es_AR.UTF-8
export LC_COLLATE=C  # For stable sorting
# export LC_ALL=''
export LC_ALL="C.UTF-8"

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export PATH="$PATH:$XDG_DATA_HOME/flatpak/exports/bin"
export PATH="$PATH:/var/lib/flatpak/exports/bin"
export PATH="$HOME/.local/bin:$PATH"
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export ANSIBLE_HOME=$XDG_CONFIG_HOME/ansible
export ANSIBLE_CONFIG=$XDG_CONFIG_HOME/ansible.cfg
export ANSIBLE_GALAXY_CACHE_DIR=$XDG_CACHE_HOME/ansible/galaxy_cache
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export PATH="$XDG_DATA_HOME/npm/bin:$PATH"
export SDKMAN_DIR=$XDG_DATA_HOME/sdkman
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(rbenv init - --no-rehash bash)"
source "$SDKMAN_DIR/bin/sdkman-init.sh"
source "$CARGO_HOME/env"
source "$XDG_DATA_HOME/bob/env/env.sh"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bob has to be installed or else it will fail
export EDITOR=$(which nvim)
# export SUDO_EDITOR="$(which nvim) -u $XDG_CONFIG_HOME/nvim/sudoedit.lua"
export SUDO_EDITOR=$(which nvim)
export VISUAL=$(which nvim)

# https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
