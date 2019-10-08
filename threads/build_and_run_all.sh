#!/usr/bin/env bash

export BENCH_ROOT=$(pwd)

echo "Running in: '$BENCH_ROOT'"
cd $BENCH_ROOT/ruby

echo ""
echo "Running in: '$(pwd)'"
echo ""

# BENCH_QTY_LOOPS=NNNN ruby bench.rb
# e.g.:
BENCH_QTY_LOOPS=${BENCH_QTY_LOOPS} ruby bench.rb
cd $BENCH_ROOT/crystal

echo ""
echo "Running in: '$(pwd)'"
echo ""

./build.sh
# BENCH_QTY_LOOPS=NNNN ./run.sh
# e.g.:
BENCH_QTY_LOOPS=${BENCH_QTY_LOOPS} ./run.sh

echo ""
echo "Done"
echo ""
