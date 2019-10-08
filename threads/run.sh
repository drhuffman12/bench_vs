#!/usr/bin/env bash

export BENCH_QTY_LOOPS=${BENCH_QTY_LOOPS:=20}

# rm -R log
mkdir -p log

rm log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
touch log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log

./build_and_run_all.sh 2>&1 | tee -a log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
cat log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
echo "File: log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log"
