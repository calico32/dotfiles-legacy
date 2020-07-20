# Sunrise theme for oh-my-zsh
# Intended to be used with Solarized: https://ethanschoonover.com/solarized

# Color shortcuts
R=$fg_no_bold[red]
G=$fg_no_bold[green]
M=$fg_no_bold[magenta]
Y=$fg_no_bold[yellow]
B=$fg_no_bold[blue]
C=$fg_no_bold[cyan]
RESET=$reset_color

if [ "$USER" = "root" ]; then
    PROMPTCOLOR="" PROMPTPREFIX="" PROMPTCHAR="%{$R%}%B#%{$RESET%}";
else
    PROMPTCOLOR="" PROMPTPREFIX="" PROMPTCHAR="%{$B%}%B%%%{$RESET%}";
fi

local return_code="%(?..%{$R%}%? ↵%{$RESET%})"

# Get the status of the working tree (copied and modified from git.zsh)
custom_git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  # Non-staged
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^.M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  # Staged
  if $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STAGED_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STAGED_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^M' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STAGED_ADDED$STATUS"
  fi

  if $(echo -n "$STATUS" | grep '.*' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_STATUS_PREFIX$STATUS"
  fi

  echo $STATUS
}

# get the name of the branch we are on (copied and modified from git.zsh)
function custom_git_prompt() {
  git symbolic-ref HEAD > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    ref=$(git symbolic-ref HEAD 2> /dev/null)
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_prompt_ahead)$ZSH_THEME_GIT_PROMPT_SUFFIX"
    #                                                                                        ^$(custom_git_prompt_status)
  else
    echo " "
  fi
}

# ⬡ ◈
# %B sets bold text
PROMPT='%B$PROMPTPREFIX%~$(custom_git_prompt)$PROMPTCHAR '
RPS1="${return_code}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$G%}〈"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$G%}〉%{$RESET%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$Y%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_AHEAD="%{$B%}⌃"


ZSH_THEME_GIT_STATUS_PREFIX=" "

# Staged
# ZSH_THEME_GIT_PROMPT_STAGED_ADDED="%{$G%}+"
# ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED="%{$G%}M"
# ZSH_THEME_GIT_PROMPT_STAGED_RENAMED="%{$G%}+"
# ZSH_THEME_GIT_PROMPT_STAGED_DELETED="%{$G%}-"

# Not-staged
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$R%}*"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$R%}*"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$R%}*"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$R%}*"
