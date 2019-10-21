#!/usr/bin/env bash

export BENCH_QTY_LOOPS=${BENCH_QTY_LOOPS:=20}

export BENCH_ROOT=$(pwd)

mkdir -p log

echo "Running in: '${BENCH_ROOT}'" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
cd $BENCH_ROOT/ruby

echo "" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
echo "Running in: '$(pwd)'" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
echo "" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log

# BENCH_QTY_LOOPS=NNNN ruby bench.rb
# e.g.:
BENCH_QTY_LOOPS=${BENCH_QTY_LOOPS} ruby bench.rb
cd $BENCH_ROOT/crystal

echo "" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
echo "Running in: '$(pwd)'" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
echo "" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log

./build.sh
# BENCH_QTY_LOOPS=NNNN ./run.sh
# e.g.:
BENCH_QTY_LOOPS=${BENCH_QTY_LOOPS} ./run.sh

echo "" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
echo "Done" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
echo "" 2>&1 | tee -a $BENCH_ROOT/log/results_combined.BENCH_QTY_LOOPS_${BENCH_QTY_LOOPS}.log
