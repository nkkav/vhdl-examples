GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--wave=fsm1p.ghw --stop-time=500ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e fsm1p_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) fsm1p_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) fsm1p.vhd
	$(GHDL) -a $(GHDLFLAGS) fsm1p_tb.vhd

force:

clean :
	rm -rf *.o work
