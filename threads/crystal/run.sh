#!/usr/bin/env bash

echo "# Crystal 0.30.0" > log/bench.log
echo >> log/bench.log
echo "- OLD" >>  log/bench.log
./bench_old >> log/bench.log

echo >> log/bench.log
echo "# Crystal 0.31.0" >> log/bench.log
echo >> log/bench.log
echo "- CRYSTAL_WORKERS=1" 
CRYSTAL_WORKERS=1 ./bench >>  log/bench.log
echo >> log/bench.log
echo "- CRYSTAL_WORKERS=2" >>  log/bench.log
CRYSTAL_WORKERS=2 ./bench >>  log/bench.log
echo >> log/bench.log
echo "- CRYSTAL_WORKERS=4" >>  log/bench.log
CRYSTAL_WORKERS=4 ./bench >>  log/bench.log
echo >> log/bench.log
echo "- CRYSTAL_WORKERS=6" >>  log/bench.log
CRYSTAL_WORKERS=6 ./bench >>  log/bench.log
echo >> log/bench.log
echo "- CRYSTAL_WORKERS=8" >>  log/bench.log
CRYSTAL_WORKERS=8 ./bench >>  log/bench.log
