#!/usr/bin/env bash
# USAGE: ./run.sh stats/os/osver/brand/model

bash collect.sh > stats_times.log 2>&1
STAT_FOLDER=$1
echo $STAT_FOLDER
mkdir -p $STAT_FOLDER
mv stats*.* $STAT_FOLDER

mkdir -p $STAT_FOLDER/crystal
mv crystal/bench $STAT_FOLDER/crystal/

mkdir -p $STAT_FOLDER/mruby
mv mruby/bench.mrb $STAT_FOLDER/mruby/
