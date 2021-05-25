#!/bin/bash

make -f ram_async.mk clean
make -f ram_async.mk init
make -f ram_async.mk run
