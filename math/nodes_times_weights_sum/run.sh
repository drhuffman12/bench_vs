#!/usr/bin/env bash
# USAGE: ./run.sh stats/os/osver/brand/model

#   e.g.: ./run.sh stats/Mint/18/Apple/MacBookPro/2017Q1

DEFAULT_STAT_FOLDER=stats/tmp
STAT_FOLDER=${1:-$DEFAULT_STAT_FOLDER}
echo $STAT_FOLDER
rm -R $STAT_FOLDER
mkdir -p $STAT_FOLDER

bash collect.sh > stats_times.log 2>&1
mv stats*.* $STAT_FOLDER

mkdir -p $STAT_FOLDER/crystal
mv crystal/bench $STAT_FOLDER/crystal/

mkdir -p $STAT_FOLDER/mruby
mv mruby/bench.mrb $STAT_FOLDER/mruby/
mv mruby/bench $STAT_FOLDER/mruby/
