QTY=1000

LOG_FILE=stats_previous

echo "duration,language,version" > $(LOG_FILE).csv
echo "misc times (TODO: merge w/ csv file)" > $(LOG_FILE).times.log

rvm use ruby-2.3.1
ruby ruby/bench.rb $QTY >> $(LOG_FILE).csv
time ruby ruby/bench.rb $QTY >> $(LOG_FILE).times.log

rvm use jruby-9.1.2.0
ruby jruby/bench.rb $QTY >> $(LOG_FILE).csv
time ruby jruby/bench.rb $QTY >> $(LOG_FILE).times.log

rvm use mruby
ruby mruby/bench.rb $QTY >> $(LOG_FILE).csv
time ruby mruby/bench.rb $QTY >> $(LOG_FILE).times.log

crenv shell 0.18.7
crystal crystal/bench.rb $QTY >> $(LOG_FILE).csv
time crystal crystal/bench.rb $QTY >> $(LOG_FILE).times.log


LOG_FILE=stats_latest.log

rvm use ruby-head
ruby ruby/bench.rb $QTY >> $(LOG_FILE).csv
time ruby ruby/bench.rb $QTY >> $(LOG_FILE).times.log

rvm use jruby-head
ruby jruby/bench.rb $QTY >> $(LOG_FILE).csv
time ruby jruby/bench.rb $QTY >> $(LOG_FILE).times.log

rvm use mruby-head
~/.rvm/rubies/mruby-head/bin/mrbc mruby/bench.rb
ruby -b mruby/bench.mrb $QTY >> $(LOG_FILE).csv
time ruby mruby/bench.rb $QTY >> $(LOG_FILE).times.log

# ~/.rvm/rubies/mruby-head/bin/mrbc -Cinit_tester mruby/bench.rb
# gcc -Imruby/src -Imruby/include -c mruby/bench.c -o mruby/bench.o
# gcc -o bench_mrb mruby/bench.o mruby/lib/libmruby.a

crenv shell 0.18.7
crystal build crystal/bench.rb --release
./crystal/bench $QTY >> $(LOG_FILE).csv
time crystal crystal/bench.rb $QTY >> $(LOG_FILE).times.log

