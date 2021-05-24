GHDL=ghdl
GHDLFLAGS=--ieee=standard --std=08 --workdir=work
GHDLRUNFLAGS=--vcd=rca.vcd --stop-time=100ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e rca_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) rca_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) rca.vhd
	$(GHDL) -a $(GHDLFLAGS) rca_tb.vhd

force:

clean :
	rm -rf *.o work
