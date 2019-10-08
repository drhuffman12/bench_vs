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
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=1" 
CRYSTAL_WORKERS=1 ./bench 2>&1 | tee -a  log/bench.log
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=2" 2>&1 | tee -a  log/bench.log
CRYSTAL_WORKERS=2 ./bench 2>&1 | tee -a  log/bench.log
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=4" 2>&1 | tee -a  log/bench.log
CRYSTAL_WORKERS=4 ./bench 2>&1 | tee -a  log/bench.log
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=6" 2>&1 | tee -a  log/bench.log
CRYSTAL_WORKERS=6 ./bench 2>&1 | tee -a  log/bench.log
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=8" 2>&1 | tee -a  log/bench.log
CRYSTAL_WORKERS=8 ./bench 2>&1 | tee -a  log/bench.log
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=10" 2>&1 | tee -a  log/bench.log
CRYSTAL_WORKERS=10 ./bench 2>&1 | tee -a  log/bench.log
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=12" 2>&1 | tee -a  log/bench.log
CRYSTAL_WORKERS=12 ./bench 2>&1 | tee -a  log/bench.log
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=14" 2>&1 | tee -a  log/bench.log
CRYSTAL_WORKERS=14 ./bench 2>&1 | tee -a  log/bench.log
echo 2>&1 | tee -a log/bench.log
echo "- CRYSTAL_WORKERS=16" 2>&1 | tee -a  log/bench.log
CRYSTAL_WORKERS=16 ./bench 2>&1 | tee -a  log/bench.log

cat log/bench.log
