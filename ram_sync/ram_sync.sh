#!/bin/bash

make -f ram_sync.mk clean
make -f ram_sync.mk init
make -f ram_sync.mk run
