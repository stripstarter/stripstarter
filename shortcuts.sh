#!/bin/bash

cat >> ~/.bashrc <<'endmsg'

# Rails aliases
alias be="bundle exec"
alias bet="RAILS_ENV=test bundle exec"
alias scommit="git commit --author='Stripstarter <stripstarter@gmail.com>' -m"
alias check="curl http://stripstarter.us"

export PATH="/opt/chefdk/bin:$PATH"

# Must be in cookbooks/ directory
function cook() {
  knife cookbook site download $1
  tarfile=$(ls | grep $1)
  tar zxf $tarfile
  rm $tarfile
  knife cookbook upload $1 -o .
}

function upload() {
  knife cookbook upload $1 -o .
}

alias download="knife cookbook site download"

endmsg

source ~/.bashrc