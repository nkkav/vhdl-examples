#!/bin/bash

make -f rom_sync.mk clean
make -f rom_sync.mk init
make -f rom_sync.mk run
