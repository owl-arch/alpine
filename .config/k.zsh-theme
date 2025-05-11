local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[blue]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local user_symbol='%(!.#.$)'
local current_dir="%B%{$fg[white]%}%~ %{$reset_color%}"

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

# Marcos Antonio de Carvalho
# inclusão para colocar horario na cor azul
myHR='%B%{$fg[magenta]%}% $(date +"%I:%M:%S")'

# Marcos Antonio de Carvalho
# Inclusão Emoji como avatar (https://profanos.com/emojis-em-texto-melhores/)
myAvatar="ಠ_ಠ"
myAvatar="(ᵔᴥᵔ)"
myAvatar="(｡◕‿◕｡)"
myAvatar="(ಠ_ಠ)"
#myAvatar="%B%{$fg[cyan]%}% ${myAvatar}"
# %{$fg[green]%}🐍

PROMPT="╭─${myHR} ${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt} 
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

# Marcos Antonio de Carvalho
# Alterado para incluir simbole do GIT
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}${myAvatar} on \uE0A0"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}on \uE0A0"
ZSH_THEME_GIT_PROMPT_PREFIX="${ZSH_THEME_GIT_PROMPT_PREFIX} %{$fg[cyan]%}"

ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ●%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✓%{$fg[cyan]%}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"