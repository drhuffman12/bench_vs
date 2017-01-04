# bash collect.sh > stats_times.log 2>&1

QTY=1000

COLLECT_ROOT=$(pwd)
# echo $COLLECT_ROOT

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

## System Info:

echo
lscpu

echo
free -m

## Stats for previous/develop versions/mode:

echo
LOG_FILE=$COLLECT_ROOT/stats_previous
# echo $LOG_FILE
echo

echo "duration,language,version" > $LOG_FILE.csv
echo "misc times (TODO: merge w/ csv file)" > $LOG_FILE.times.log 2>&1

echo
rvm use ruby-2.3.1
ruby --version
for VARIABLE in 1 2 3 4 5
do
  ruby ruby/bench.rb $QTY >> $LOG_FILE.ruby-2.3.1.csv
done
time ruby ruby/bench.rb $QTY >> $LOG_FILE.ruby-2.3.1.times.log 2>&1

echo
rvm use ruby-2.4.0
ruby --version
for VARIABLE in 1 2 3 4 5
do
  ruby ruby/bench.rb $QTY >> $LOG_FILE.ruby-2.4.0.csv
done
time ruby ruby/bench.rb $QTY >> $LOG_FILE.ruby-2.4.0.times.log 2>&1

echo
rvm use jruby-1.7.25
ruby --version
for VARIABLE in 1 2 3 4 5
do
jruby jruby/bench.rb $QTY >> $LOG_FILE.csv
done
time jruby jruby/bench.rb $QTY >> $LOG_FILE.times.log 2>&1

echo
rvm use mruby
ruby --version
for VARIABLE in 1 2 3 4 5
do
ruby mruby/bench.rb $QTY >> $LOG_FILE.csv
done
time ruby mruby/bench.rb $QTY >> $LOG_FILE.times.log 2>&1

echo
echo "Crystal 0.18.7 (non-release)"
crenv local 0.18.7
crystal version
for VARIABLE in 1 2 3 4 5
do
crystal ./crystal/bench.cr $QTY >> $LOG_FILE.0.18.7.csv
done
time crystal ./crystal/bench.cr $QTY >> $LOG_FILE.0.18.7.times.log 2>&1

## Stats for latest/production versions/mode:

echo
LOG_FILE=$COLLECT_ROOT/stats_latest
# echo $LOG_FILE
echo

echo "duration,language,version" > $LOG_FILE.csv
echo "misc times (TODO: merge w/ csv file)" > $LOG_FILE.times.log 2>&1


echo
rvm use ruby-head
ruby --version
for VARIABLE in 1 2 3 4 5
do
ruby ruby/bench.rb $QTY >> $LOG_FILE.csv
done
time ruby ruby/bench.rb $QTY >> $LOG_FILE.times.log 2>&1

echo
rvm use jruby-9.1.2.0
ruby --version
# rvm use jruby-head
for VARIABLE in 1 2 3 4 5
do
jruby jruby/bench.rb $QTY >> $LOG_FILE.csv
done
time jruby jruby/bench.rb $QTY >> $LOG_FILE.times.log 2>&1

echo
echo 'mrb'
rvm use mruby-head
ruby --version
#~/.rvm/rubies/mruby-head/bin/mrbc mruby/bench.rb
mrbc mruby/bench.rb
ruby -b mruby/bench.mrb $QTY
for VARIABLE in 1 2 3 4 5
do
ruby -b mruby/bench.mrb $QTY >> $LOG_FILE.csv
done
time ruby -b mruby/bench.mrb $QTY >> $LOG_FILE.times.log 2>&1


# ~/.rvm/rubies/mruby-head/bin/mrbc -Cinit_tester mruby/bench.rb
# gcc -Imruby/src -Imruby/include -c mruby/bench.c -o mruby/bench.o
# gcc -o bench_mrb mruby/bench.o mruby/lib/libmruby.a

echo
echo "Crystal 0.18.7 (release)"

crenv shell 0.18.7
crystal version
crystal build ./crystal/bench.cr --release # --emit obj --prelude=empty --release
cp bench ./crystal/bench_0.18.7
mv bench ./crystal/bench
for VARIABLE in 1 2 3 4 5
do
./crystal/bench $QTY >> $LOG_FILE.0.18.7_release.csv
done
time ./crystal/bench $QTY >> $LOG_FILE.0.18.7_release.times.log 2>&1

echo
echo "Crystal 0.19.0 (release)"

crenv shell 0.19.0
crystal version
crystal build ./crystal/bench.cr --release # --emit obj --prelude=empty --release
cp bench ./crystal/bench_0.19.0
mv bench ./crystal/bench
for VARIABLE in 1 2 3 4 5
do
./crystal/bench $QTY >> $LOG_FILE.0.19.0_release.csv
done
time ./crystal/bench $QTY >> $LOG_FILE.0.19.0_release.times.log 2>&1

echo
echo "Crystal 0.19.4 (release)"

crenv shell 0.19.4
crystal version
crystal build ./crystal/bench.cr --release # --emit obj --prelude=empty --release
cp bench ./crystal/bench_0.19.4
mv bench ./crystal/bench
for VARIABLE in 1 2 3 4 5
do
./crystal/bench $QTY >> $LOG_FILE.0.19.4_release.csv
done
time ./crystal/bench $QTY >> $LOG_FILE.0.19.4_release.times.log 2>&1

echo
echo "Crystal 0.20.0 (release)"

crenv shell 0.20.0
crystal version
crystal build ./crystal/bench.cr --release # --emit obj --prelude=empty --release
cp bench ./crystal/bench_0.20.0
mv bench ./crystal/bench
for VARIABLE in 1 2 3 4 5
do
./crystal/bench $QTY >> $LOG_FILE.0.20.0_release.csv
done
time ./crystal/bench $QTY >> $LOG_FILE.0.20.0_release.times.log 2>&1

echo
echo "Crystal 0.20.1 (release)"

crenv shell 0.20.1
crystal version
crystal build ./crystal/bench.cr --release # --emit obj --prelude=empty --release
cp bench ./crystal/bench_0.20.1
mv bench ./crystal/bench
for VARIABLE in 1 2 3 4 5
do
./crystal/bench $QTY >> $LOG_FILE.0.20.1_release.csv
done
time ./crystal/bench $QTY >> $LOG_FILE.0.20.1_release.times.log 2>&1


echo
echo "Crystal 0.20.3 (release)"

crenv shell 0.20.3
crystal version
crystal build ./crystal/bench.cr --release # --emit obj --prelude=empty --release
cp bench ./crystal/bench_0.20.3
mv bench ./crystal/bench
for VARIABLE in 1 2 3 4 5
do
./crystal/bench $QTY >> $LOG_FILE.0.20.3_release.csv
done
time ./crystal/bench $QTY >> $LOG_FILE.0.20.3_release.times.log 2>&1

echo
echo "Crystal 0.20.4 (release)"

crenv shell 0.20.4
crystal version
crystal build ./crystal/bench.cr --release # --emit obj --prelude=empty --release
cp bench ./crystal/bench_0.20.4
mv bench ./crystal/bench
for VARIABLE in 1 2 3 4 5
do
./crystal/bench $QTY >> $LOG_FILE.0.20.4_release.csv
done
time ./crystal/bench $QTY >> $LOG_FILE.0.20.4_release.times.log 2>&1

## Mruby:

echo
echo 'minirake'
#
cp mruby/bench.rb tmp/mruby/mrblib
cd tmp/mruby

rvm use ruby-2.3.1
./minirake -q
cd ../..
# echo "./bench -e \"Bench.run(1000)\"" > mruby/bench.sh
#
cp tmp/mruby/bin/mruby mruby/
mv mruby/mruby mruby/bench

# cd mruby
mruby/bench --version
mruby/bench -e "Bench.run(1000)"
for VARIABLE in 1 2 3 4 5
do
mruby/bench -e "Bench.run(1000)" >> $LOG_FILE.csv
done
time mruby/bench -e "Bench.run(1000)" >> $LOG_FILE.times.log 2>&1

echo
