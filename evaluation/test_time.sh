#!/usr/bin/env sh
CAFFE_BIN=../PSPNet/build/tools/caffe
$CAFFE_BIN time -model=./prototxt/icnet_cityscapes.prototxt -gpu 0 -iterations 100 2>&1 | tee time.log
