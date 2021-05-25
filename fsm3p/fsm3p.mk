GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--wave=fsm3p.ghw --stop-time=300ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e fsm3p_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) fsm3p_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) fsm3p.vhd
	$(GHDL) -a $(GHDLFLAGS) fsm3p_tb.vhd

force:

clean :
	rm -rf *.o work
