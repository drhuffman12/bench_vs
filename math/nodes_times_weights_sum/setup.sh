# bash setup.sh

rvm get stable --auto-dotfiles
rvm get head
rvm cleanup all

git clone https://github.com/pine/crenv-update.git "$(crenv root)/plugins/crenv-update"
crenv update

rvm install ruby-2.3.1
rvm install jruby-1.7.25
rvm install mruby
crenv install 0.18.6

rvm install ruby-head
rvm install jruby-9.1.2.0
# rvm install jruby-head
rvm install mruby-head
crenv install 0.18.7
