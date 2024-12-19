# Add profiling capabilities
#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less

# some more ls aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# set minikube alias
alias kubectl="minikube kubectl --"

# set less slurm-<latest>.log
alias lesss='less $(ls -1 slurm-*.out | sort -V | tail -n 1)'

function command_exists {
  #this should be a very portable way of checking if something is on the path
  #usage: "if command_exists foo; then echo it exists; fi"
  type "$1" &> /dev/null
}

ssh_env=~/.ssh/agent.env

agent_load_env () { test -f "$ssh_env" && . "$ssh_env" >| /dev/null ; }

agent_start () {
      (umask 077; ssh-agent >| "$ssh_env")
      . "$ssh_env" >| /dev/null ; 
}

start-ssh-agent() {
  agent_load_env

  #agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
  agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

  if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
  elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
  fi
}

# enable and configure fzf fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/\.git/*'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND="find . -type d -not -path '*/\.git/*'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# function wrapper to issue molecule commands for multiple distros
mmolecule() {
    local distros
    local default_distros=$(awk 'match($0, /distro: \[.*\]/) {print substr($0, RSTART+9, RLENGTH-10)}' .github/workflows/ci.yml)

    if [ -n "$1" ]
    then
        distros="$1"
        shift

        if [ "$distros" = "all" ]; then
          distros=$default_distros
        fi

        IFS=',' read -rA DISTROS <<< "$distros"
        for dist in "${DISTROS[@]}"; do
          MOLECULE_DISTRO=$dist molecule "$@"
        done
    else
        echo "Usage: mmolecule <distros> <commands/options>"
    fi
}

export PATH="$HOME/tools/nvim/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# set editor alias
if command_exists nvim; then
  alias v="nvim"
  export EDITOR="nvim"
else
  alias v="vim"
  export EDITOR="vim"
fi

export VISUAL="$EDITOR"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if command_exists conda; then
  eval "$(conda shell.zsh hook)"
fi

# Stop profiling
#zprof
