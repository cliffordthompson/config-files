################################################################################
##
## Copyright (c) 2015 Clifford Thompson
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org
##
################################################################################

# Get the global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias ll='ls -alG'
alias grep='grep --color=auto -n'

source ~/.gitscripts/git-completion.sh
source ~/.gitscripts/git-prompt.sh

export PS1='\e[32m[\d \t\e[33m$(__git_ps1 " (%s)")\e[32m \W]\e[37m: '

