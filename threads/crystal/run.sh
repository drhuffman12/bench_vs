#!/usr/bin/env bash

# rm -R log
mkdir log
rm -R tmp
mkdir tmp

touch log/bench.log

# echo "# Crystal 0.30.0" > log/bench.log
# echo 2>&1 | tee -a log/bench.log
# echo "- OLD" 2>&1 | tee -a  log/bench.log
# ./bench_old 2>&1 | tee -a log/bench.log

echo 2>&1 | tee -a log/bench.log
crystal -v 2>&1 | tee -a log/bench.log

for i in {1..128}
do
  echo 2>&1 | tee -a log/bench.log
  echo "- CRYSTAL_WORKERS=${i}" 2>&1 | tee -a log/bench.log
  CRYSTAL_WORKERS=$i ./bench 2>&1 | tee -a  log/bench.log
done

cat log/bench.log
# ls -al log/bench.cr.*.csv

# Aggregate results
cat tmp/bench.cr.ql_${BENCH_QTY_LOOPS}.*.csv > log/bench.cr.ql_${BENCH_QTY_LOOPS}.csv
