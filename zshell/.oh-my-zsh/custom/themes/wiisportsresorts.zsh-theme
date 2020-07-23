# colors
# %B sets bold text
R=$fg_no_bold[red]
G=$fg_no_bold[green]
M=$fg_no_bold[magenta]
Y=$fg_no_bold[yellow]
B=$fg_no_bold[blue]
C=$fg_no_bold[cyan]
RESET=$reset_color

if [ "$USER" = "root" ]; then
  # show red #
  PROMPTCHAR="%{$R%}%B#%{$RESET%}"
else
  # show blue %
  PROMPTCHAR="%{$B%}%B%%%{$RESET%}"
fi

# git modifiers
ZSH_THEME_GIT_PROMPT_DIRTY="%{$Y%}*"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$B%}⌃"

custom_git_prompt() {
  git symbolic-ref HEAD >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    ref=$(git symbolic-ref HEAD 2>/dev/null)

    # the * and/or ^, signifying dirty and/or ahead
    local gitmodchars=" $(parse_git_dirty)$(git_prompt_ahead)"
    # remove space if not dirty or ahead
    [ "$gitmodchars" = " " ] && gitmodchars=""

    echo "%{$G%} [${ref#refs/heads/}${gitmodchars}%{$G%}] %{$RESET%}"
  else
    echo " "
  fi
}

# must be single quotes
PROMPT='%B%~$(custom_git_prompt)$PROMPTCHAR '

# right side return code
RPS1="%(?..%{$R%}%? ↵%{$RESET%})"

# terminal title
ZSH_THEME_TERM_TITLE_IDLE="zsh: %~"
