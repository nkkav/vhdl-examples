GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--vcd=ram_sync.vcd --stop-time=500ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e ram_sync_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) ram_sync_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) ram_sync.vhd
	$(GHDL) -a $(GHDLFLAGS) ram_sync_tb.vhd

force:

clean :
	rm -rf *.o work
