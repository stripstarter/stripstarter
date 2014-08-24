#!/bin/bash

cat >> ~/.bashrc <<'endmsg'

# Rails aliases
alias be="bundle exec"
alias bet="RAILS_ENV=test bundle exec"
alias scommit="git commit --author='Stripstarter <stripstarter@gmail.com>' -m"
endmsg

source ~/.bashrc