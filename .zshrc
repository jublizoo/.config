# Conda init is VERY slow!!
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/jhenn/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/jhenn/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/jhenn/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/jhenn/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# Colors are red, blue, green, cyan, yellow, magenta, black, & white
autoload -U colors && colors
# %n is username
# %m is hostname
# %~ is current directory
# %% is a literal %
# Below reads as [red]user[reset]@[blue]host [yellow]~/path [reset]%
export PS1="%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg[green]%}%~ %{$reset_color%}%% "
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=/Applications/Alacritty.app/Contents/MacOS/:$PATH
export PATH='/Users/jhenn/bin':$PATH
export PATH='/Users/jhenn/.duckdb/cli/latest':$PATH

# Vim mode
bindkey -v
# Makes delete work with the viins keymap, using the ZLE backward-delete-char widget.
# The '^?' is an escape character for delete
# -M specifies the keymap for which to remap
bindkey -M vicmd '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char

# With lsd, -G not needed for colors
alias ls='lsd -AF --group-dirs=first'
alias cd='z'

# Setup zoxide
eval "$(zoxide init zsh)"

source $HOME/.elan/env

. "$HOME/.cargo/env"

# \e is Esc, ]0; is sequence start?
function set_title() {
	print "\e]0;$1"
}
