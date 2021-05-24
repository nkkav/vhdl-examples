GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--vcd=priority.vcd --stop-time=500ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e priority_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) priority_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) priority.vhd
	$(GHDL) -a $(GHDLFLAGS) priority_tb.vhd

force:

clean :
	rm -rf *.o work
