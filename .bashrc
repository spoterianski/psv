# Thanks Ignat (https://github.com/Kontakter/Ignat)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Write comment to this command
#shopt -s cdspell

# default editor
export EDITOR=vim

# git stuff
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    complete -o default -o nospace -F _git g
fi

# usefull aliases for ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias g='git'
alias v='vim'
alias gp='git pkg'
alias gclean='git clean -d -x -n'

# aliases to tar extract and compress
alias tc='tar cvzf'
alias tx='tar xvzf'


platform=`uname`

# Status line
if [[ "$color_prompt" == yes || "$platform" == "Darwin" ]]; then
    NORMAL="\[\e[0m\]"
    RED="\[\e[1;31m\]"
    GREEN="\[\e[1;32m\]"
    YELLOW="\[\033[0;33m\]"
else
    NORMAL=""
    RED=""
    GREEN=""
    YELLOW=""
fi
export PS1="$RED\u@\h:$NORMAL\w$YELLOW\$(__git_ps1)$GREEN\$$NORMAL "


if [[ "$platform" == "Darwin" ]]; then
    # MacPorts Installer addition on 2011-06-26_at_12:43:19: adding an appropriate PATH variable for use with MacPorts.
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    # Finished adapting your PATH environment variable for use with MacPorts.

    # Colorize output of ls
    export LSCOLORS=Exfxcxdxbxegedabagacad
    alias ls="ls -FG"

    export PROJECTS="/Volumes/work/psv/Projects"


elif [[ "$platform" == "Linux" ]]; then

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
        else
        color_prompt=
        fi
    fi


    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
        ;;
    *)
        ;;
    esac

    if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi



    # Variables for use debian
    export EMAIL="spoterianski@gmail.com"
    export DEBFULLNAME="Sergey Poterianski"
    export BOOST_TEST_LOG_LEVEL=messages

    # tmux completion and restore
    refresh_tmux() {
        if [[ -n $TMUX ]]; then
            NEW_SSH_AUTH_SOCK=`tmux showenv | grep ^SSH_AUTH_SOCK | cut -d = -f 2`
            if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then
                SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
            fi
        fi
    }
    if [ -f ~/.tmux-completion.bash ]; then
        source ~/.tmux-completion.bash
    fi
    alias tm="tmux attach-session -t 0"
    alias rtm="refresh_tmux"
fi

