# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gozilla"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.oh-my-zsh-custom

plugins=(git extract svn gradle)

# User configuration
# Path
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$PATH:$HOME/.local/bin" # pip modules
export PATH="$PATH:$HOME/Config/bin" # scripts
export PATH="$PATH:$HOME/.npm-packages/bin" # npm
#export PATH="$HOME/.rbenv/bin:$PATH"
#export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Variables
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export EDITOR="vim"
export ICAROOT="/opt/Citrix/ICAClient" # Citrix

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

# Shortcut
# Alt+l for "ll"
bindkey -s '^[l' 'll\n'

# Ruby
#eval "$(rbenv init -)"
