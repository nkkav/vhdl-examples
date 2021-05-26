GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--vcd=rom_sync.vcd --stop-time=1000ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e rom_sync_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) rom_sync_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) rom_sync.vhd
	$(GHDL) -a $(GHDLFLAGS) rom_sync_tb.vhd

force:

clean :
	rm -rf *.o work
