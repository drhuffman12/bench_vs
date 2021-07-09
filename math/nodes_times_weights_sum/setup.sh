# bash setup.sh

git submodule update

## Make RVM and CRENV happy:

# exec $SHELL -l
PATH="$HOME/.crenv/bin:$PATH"
eval "$(crenv init -)"

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then

  # First try to load from a user install
  source "$HOME/.rvm/scripts/rvm"

elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then

  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"

else

  printf "ERROR: An RVM installation was not found.\n"

fi

# rvm get stable --auto-dotfiles
rvm get head --auto-dotfiles
rvm cleanup all

git clone https://github.com/pine/crenv-update.git "$(crenv root)/plugins/crenv-update"
crenv update

rvm install ruby-2.3.1
rvm install ruby-2.4.0
rvm install jruby-1.7.25
rvm install mruby
crenv install 0.18.6

rvm install ruby-head
rvm install jruby-9.1.2.0
# rvm install jruby-head
rvm install mruby-head
crenv install 0.18.7
crenv install 0.19.0
crenv install 0.19.4
crenv install 0.20.0
crenv install 0.20.1
crenv install 0.20.3
crenv install 0.20.4

rm -R tmp/mruby
mkdir -p tmp/mruby
cp -R ../../languages/mruby/head/mruby/ tmp
