#!/bin/bash

make -f bcdcounter.mk clean
make -f bcdcounter.mk init
make -f bcdcounter.mk run

exit 0
