#!/usr/bin/env bash

rm -R log
mkdir log

touch log/bench.log

# echo "# Crystal 0.30.0" > log/bench.log
# echo 2>&1 | tee -a log/bench.log
# echo "- OLD" 2>&1 | tee -a  log/bench.log
# ./bench_old 2>&1 | tee -a log/bench.log

echo 2>&1 | tee -a log/bench.log
echo "# Crystal 0.31.0" 2>&1 | tee -a log/bench.log

for i in {1..32}
do
  echo 2>&1 | tee -a log/bench.log
  echo "- CRYSTAL_WORKERS=${i}" 2>&1 | tee -a log/bench.log
  CRYSTAL_WORKERS=$i ./bench 2>&1 | tee -a  log/bench.log
done

cat log/bench.log
