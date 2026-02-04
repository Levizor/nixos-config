# Load Zsh modules

# Initialize colors
autoload -Uz colors
colors

_comp_options+=(globdots)

# Load edit-command-line for ZLE
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line

# General completion behavior
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' complete true

# Use cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Autocomplete options
# zstyle ':completion:*' complete-options true

# Completion matching control
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' keep-prefix true

# Group matches and describe
zstyle ':completion:*' menu select
zstyle ':completion:*' list-grouped false
zstyle ':completion:*' list-separator ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format '[%d]'

# Colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true

# Sort
zstyle ':completion:*' sort false
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:lsd' sort false
zstyle ':completion:complete:*:options' sort false
zstyle ':completion:files' sort false

# fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --group-directories-first -1 --color=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'lsd --group-directories-first -1 --color=always $realpath'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' fzf-min-height 100
zstyle ':fzf-tab:*' switch-group ',' '.'

# magic-enter
zstyle -s ':zshzoo:magic-enter' command 'lsd'
zstyle -s ':zshzoo:magic-enter' git-command 'lsd'

# ==========
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf-preview 'lsd --tree --color=always {} | head -200' "$@" ;;
    ssh)          fzf-preview 'dig {}'                   "$@" ;;
    *)            fzf-preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Magic enter oh-my-zsh plugin setup
MAGIC_ENTER_OTHER_COMMAND='ls'
MAGIC_ENTER_GIT_COMMAND='ls'
