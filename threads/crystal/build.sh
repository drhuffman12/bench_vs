#!/usr/bin/env bash

# build for Crystal v0.30.0
# TODO

# build for Crystal v0.31.0
time crystal build -Dpreview_mt --release bench.cr
