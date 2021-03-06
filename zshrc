# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mortalscumbag"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git command-not-found fasd)

source $ZSH/oh-my-zsh.sh

# ruby gems
PATH=$PATH:~/.gem/ruby/2.2.0/bin

alias c='transmission-remote-cli'
alias m='mutt'
alias n='ncmpcpp'
alias t='tig --all'

alias sudo='nocorrect sudo'
alias ls='ls --group-directories-first --color=tty'

if [ "$TERM" != "dumb" ]; then
	eval $(dircolors -b ~/.dircolors)
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

export P4CONFIG=.p4config
