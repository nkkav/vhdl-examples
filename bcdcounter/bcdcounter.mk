GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--vcd=bcdcounter.vcd --stop-time=800ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e bcdcounter_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) bcdcounter_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) bcdcounter.vhd
	$(GHDL) -a $(GHDLFLAGS) bcdcounter_tb.vhd

force:

clean :
	rm -rf *.o work
