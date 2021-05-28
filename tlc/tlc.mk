GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--vcd=tlc.ghw --stop-time=10000ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e tlc_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) tlc_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) tlc.vhd
	$(GHDL) -a $(GHDLFLAGS) tlc_tb.vhd

force:

clean :
	rm -rf *.o work
