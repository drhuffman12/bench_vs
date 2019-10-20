
# Comparing Threads, Fibers, Plain (and TODO: Processes)

## Ruby

```bash
cd $BENCH_ROOT
cd ruby
# BENCH_QTY_LOOPS=NNNN ruby bench.rb
# e.g.:
BENCH_QTY_LOOPS=10 ruby bench.rb
```

## Crystal

```bash
cd $BENCH_ROOT
cd crystal
./build.sh
# BENCH_QTY_LOOPS=NNNN ./run.sh
# e.g.:
BENCH_QTY_LOOPS=10 ./run.sh
```

## Both

```bash
# BENCH_QTY_LOOPS=NNNN ./build_and_run_all.sh
# e.g.:
BENCH_QTY_LOOPS=10 bash ./run.sh
```

## Debug

```bash
BENCH_QTY_LOOPS=10 CRYSTAL_WORKERS=7 crystal bench.cr -d
```
