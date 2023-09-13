# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.dotfiles/powerlevel10k/powerlevel10k.zsh-theme

autoload -Uz compinit
compinit

bindkey -v
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
# export HISTSIZE=2000 export SAVEHIST=7000
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zhistory"

export VISUAL=/usr/bin/vim

alias c='clear'
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias lsc='ls -lh; echo "total files: `ls |wc -l`"'
alias lr='ls -lR'                                                # recursive ls
alias lt='ls -ltr'                                               # sort by date, most recent last
alias path='echo -e ${PATH//:/\\n}'
alias psgrep='__grep_for_arg_without_grep'

alias please='sudo'
alias puts="echo $1"
alias rld='. ~/.zshrc'

alias vb='nvim ~/.zshrc'
alias e='nvim'
alias :e='nvim'
# alias vi='nvim'
# alias vim='nvim'
alias :q='exit'
alias q='exit'
alias :gs='gws'
alias git='/usr/bin/git'
alias gc='git commit'
alias gws='git status --ignore-submodules="none" --short'
alias gpc='git push --set-upstream origin "$(~/.dotfiles/bin/git-branch-current 2> /dev/null)"'
alias gpp='git push origin `~/.dotfiles/bin/git-branch-current`'
alias opr='open $(git remote get-url origin)/pull/$(~/.dotfiles/bin/git-branch-current)'
alias gcompare='open $(git remote get-url origin)/compare/$(~/.dotfiles/bin/git-branch-current)'
alias gco='git checkout -- Gemfile.lock; git co'
alias console='./script/console --pry'

function cjq() {
  curl $1 | jq .
}

#bundler
alias be='bundle exec'
alias bec='bundle exec cap'
alias ber='bundle exec rails'
alias bek='bundle exec rake'

alias ggrep='gem list |grep $1'

# alias serve='ruby -run -ehttpd ${$1:.} -p8000'
function serve() {
  ruby -run -ehttpd ${1:-.} -p8000
}

alias tt='nocorrect tt'

# function mkexe() {
#   touch $1
#   chmod +x $1
# }

## tmux commands
alias tma="tmux attach -t $2"
alias tmn="__create_new_tmux_session $1 $2 $3"
alias tml="tmux ls"

#vagrant
# alias vsd='vagrant ssh default'
# alias vud='vagrant up default'
# alias vup='vagrant up'
# alias sup='sudo echo "fuck you" && vagrant up'
# alias vss='vagrant ssh'
# alias v='vagrant'

#alias csssh="TERM=xterm-256color gh cs ssh"

#docker
alias doc='docker'
alias dco='docker-compose'

function __create_new_tmux_session (){
  echo "creating tmux session named $1"
  if [ -z ${2} ]; then
    echo $1
    tmux new-session -d -s $1 -n $1
    echo $?
  else
    tmux new-session -d -s $1 -n $2
  fi
  if [ -z ${3} ]
  then
    echo "not cding"
  else
    tmux send-keys -t $1 "cd $3" C-m
    tmux set-option -t $1 default-path $3
  fi
	tmux send-keys -t $1 'clear; pwd' C-m
  tmux attach -t $1
}

function __grep_for_arg_without_grep () {
  ps -A |grep -i $1 |grep -v "grep"
}

function poll_cmd() {
  chsum1=""

  while [ true ]
  do
    chsum2=`find ./ -type f -iname "*.rb" -exec md5 {} \;`
    if [[ $chsum1 != $chsum2 ]] ; then           
      eval $1
      chsum1=$chsum2
    else
      sleep 2
    fi
  done
}

function poll_cmd_exs() {
  chsum1=""

  while [ true ]
  do
    chsum2=`find ./ -type f -iname "*.ex*" -exec md5 {} \;`
    if [[ $chsum1 != $chsum2 ]] ; then
      eval $1
      chsum1=$chsum2
    else
      sleep 2
    fi
  done
}
function timeout_cmd() {
  while [ true ]; do
    eval $2
    sleep $1
  done
}

function sw() {
  if [ -z $2 ]; then
    cpv=".copy"
  else
    cpv=$2
  fi
  if [ -f "$1.$cpv" ] || [ -d "$1.$cpv" ]; then
    mv "$1" "$1.temp"
    mv "$1.$cpv" $1
    mv "$1.temp" "$1.$cpv"
  else
    cp "$1" "$1.$cpv"
  fi
}

# export PATH=$PATH:'/Applications/Postgres.app/Contents/Versions/9.6/bin':/Users/jsw/bin:/Users/jsw/.cargo/bin
if [[ $PATH != *"./bin:"* ]]; then
  export PATH=./bin:$PATH
fi

if [[ $PATH != *"$HOME/bin:"* ]]; then
  export PATH=$HOME/bin:$PATH
fi

if [[ $PATH != *"$HOME/.rbenv/bin"* ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

alias rubies='ls ~/.rubies'

#RUBIES+=("$HOME/.rbenv/versions"/*)

#if [[ -z "$RUBY_ROOT" || ! -z "TMUX" ]]; then
#  chruby 2.5.1
#fi

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
alias ag='rg'

alias gtt='rt `git ls-files -m test`'


if [[ $PATH != *"$HOME/.rbenv/shims"* && -f "$HOME/.rbenv/bin/rbenv" ]]; then
  eval "$($HOME/.rbenv/bin/rbenv init -)"
fi

export ERL_AFLAGS="-kernel shell_history enabled"

bindkey "^R" history-incremental-pattern-search-backward
#source ~/dotfiles/shell/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias monitor-window="tmux set-window-option monitor-activity on"
alias unmonitor-window="tmux set-window-option monitor-activity off"

alias axel="axel -a"

export EDITOR='vim'

alias ls="ls -G"

alias rt="./bin/rails test -p "

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

source "$HOME/.dotfiles/system.zshrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias '??'='github-copilot-cli what-the-shell'
alias 'git?'='github-copilot-cli git-assist'
alias 'gh?'='github-copilot-cli gh-assist'

