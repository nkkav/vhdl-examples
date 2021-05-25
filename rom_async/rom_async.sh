#!/bin/bash

make -f rom_async.mk clean
make -f rom_async.mk init
make -f rom_async.mk run
