
#'########:'####::'######::'##::::'##:::::'######:::'#######::'##::: ##:'########:'####::'######:::
# ##.....::. ##::'##... ##: ##:::: ##::::'##... ##:'##.... ##: ###:: ##: ##.....::. ##::'##... ##::
# ##:::::::: ##:: ##:::..:: ##:::: ##:::: ##:::..:: ##:::: ##: ####: ##: ##:::::::: ##:: ##:::..:::
# ######:::: ##::. ######:: #########:::: ##::::::: ##:::: ##: ## ## ##: ######:::: ##:: ##::'####:
# ##...::::: ##:::..... ##: ##.... ##:::: ##::::::: ##:::: ##: ##. ####: ##...::::: ##:: ##::: ##::
# ##:::::::: ##::'##::: ##: ##:::: ##:::: ##::: ##: ##:::: ##: ##:. ###: ##:::::::: ##:: ##::: ##::
# ##:::::::'####:. ######:: ##:::: ##::::. ######::. #######:: ##::. ##: ##:::::::'####:. ######:::
#..::::::::....:::......:::..:::::..::::::......::::.......:::..::::..::..::::::::....:::......::::


set_color yellow && echo "    
 ██████╗ ██████╗  █████╗ ██╗  ██╗███╗   ███╗
 ██╔══██╗██╔══██╗██╔══██╗██║  ██║████╗ ████║
 ██████╔╝██████╔╝███████║███████║██╔████╔██║
 ██╔══██╗██╔══██╗██╔══██║██╔══██║██║╚██╔╝██║
 ██████╔╝██║  ██║██║  ██║██║  ██║██║ ╚═╝ ██║
 ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝"

# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"


# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Starship prompt
#if status --is-interactive
#   source ("/usr/bin/starship" init fish --print-full-init | psub)
#end

## Advanced command-not-found hook
#source /usr/share/doc/find-the-command/ftc.fish

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | egrep '^\.'" # show only dotfiles

# Replace some more things with better alternatives
# alias cat='bat --style header --style rules --style snip --style changes --style header'

# Common use
alias grubup="sudo update-grub"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='/usr/bin/update'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info



# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

alias nx="nvim"
alias tmux="tmux -u"
alias tx="emacs -nw -l ~/.config/emacs/tx.el"
alias k8s="kubectl"
alias mi="micro"

alias clear="clear && echo -e '\e[1;33m
 ██████╗ ██████╗  █████╗ ██╗  ██╗███╗   ███╗
 ██╔══██╗██╔══██╗██╔══██╗██║  ██║████╗ ████║
 ██████╔╝██████╔╝███████║███████║██╔████╔██║
 ██╔══██╗██╔══██╗██╔══██║██╔══██║██║╚██╔╝██║
 ██████╔╝██║  ██║██║  ██║██║  ██║██║ ╚═╝ ██║
 ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝'"

starship init fish | source

# theme_gruvbox darke
#
# figlet chingz -f slant | lolcat -F 0.7 -p 0.1 -a -s 100

# set cargo path
set --export PATH $HOME/.cargo/bin $PATH

# Enble local dir o path
set --export PATH $HOME/.local/bin $PATH

# Flatpak enable on fish
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end

# Kubectl completion 
kubectl completion fish | source
