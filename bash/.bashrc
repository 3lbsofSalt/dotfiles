#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -a --color=auto'
alias ll='ls -lah --color=auto'
alias gs='git status'
alias py='python'


git_branch="`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`"

# To understand this, there is some helpful information to be found if you run info bash
function color_my_prompt {
  local __user_and_host="\[\033[01;32m\]\u@\h"
  local __cur_location="\[\033[01;34m\]\w"
  local __git_branch_color="\[\033[31m\]"
  #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
  local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
  local __prompt_tail="\[\033[35m\]$"
  local __last_color="\[\033[00m\]"
  export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

[[ -n "$_TUTR" ]] && source $_TUTR || true  # shell tutorial shim DO NOT MODIFY


shortcuts() { # DO NOT MODIFY. SHORTCUTS COMMAND ADDED BY SHELL TUTORIAL
cat <<-:
Shortcut | Action
---------|-----------------------------------------------
  Up     | Bring up older commands from history
  Down   | Bring up newer commands from history
  Left   | Move cursor BACKWARD one character
  Right  | Move cursor FORWARD one character
Backspace| Erase the character to the LEFT of the cursor
  Delete | Erase the character to the RIGHT the cursor
  ^A     | Move cursor to BEGINNING of line
  ^E     | Move cursor to END of line
  M-B    | Move cursor BACKWARD one whole word
  M-F    | Move cursor FORWARD one whole word
  ^C     | Cancel (terminate) the currently running process
  TAB    | Complete the command or filename at cursor
  ^W     | Cut BACKWARD from cursor to beginning of word
  ^K     | Cut FORWARD from cursor to end of line (kill)
  ^Y     | Yank (paste) text to the RIGHT the cursor
  ^L     | Clear the screen while preserving command line
  ^U     | Cut the entire command line
:
}

bind -s 'set completion-ignore-case on'
