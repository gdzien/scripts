# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

mcd() {
  mkdir $1 && cd $1
}

__git_ps1() {
    local x_git_BRANCH=$(git name-rev --name-only @)
    echo -n "(${x_git_BRANCH})"
    unset x_git_BRANCH
}

set_prompt()
{
   local last_cmd=$?
   local txtreset='$(tput sgr0)'
   local txtred='$(tput setaf 1)'
   local txtgreen='$(tput setaf 2)'
   local fancyx='\342\234\227'
   local checkmark='\342\234\223'
   
   # Green ✓ or ✗ and ($?)
   if [[ $last_cmd == 0 ]]; then
      PS1="\[$txtgreen\]$checkmark \[$txtreset\](0)"
   else
      PS1="\[$txtred\]$fancyx \[$txtreset\]($last_cmd)"
   fi
   # Good old [
   PS1+=" ["
   # root in red 
   if [[ $EUID == 0 ]]; then
       PS1+="\[$txtred\]"
   else
       PS1+="\[$txtreset\]"
   fi
   # user@host
   PS1+="\u\[$txtreset\]@\h$txtreset"
   # working directory
   if [[ ${PWD##*/} == $LOGNAME ]]; then
     PS1+=" ~"
   else
      PS1+=" ${PWD##*/}"
   fi
   # green git branch (run only if in git_direcotry)
   git rev-parse --is-inside-work-tree &> /dev/null && \
     PS1+=" \[$txtgreen\]$(__git_ps1 ' (%s)')\[$txtreset\]"
   # $ for user, # for root
   PS1+="]\\$ "
}
PROMPT_COMMAND='set_prompt'
