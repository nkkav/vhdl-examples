GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--wave=gcd.ghw --stop-time=1060ns

# Default target : elaborate
all : run

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e gcd_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) gcd_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) gcd.vhd
	$(GHDL) -a $(GHDLFLAGS) gcd_tb.vhd

force:

clean :
	rm -rf *.o work
