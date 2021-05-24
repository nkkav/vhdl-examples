GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--vcd=dreg.vcd --stop-time=500ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e dreg_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) dreg_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) dreg_srst_en.vhd
	$(GHDL) -a $(GHDLFLAGS) dreg_tb.vhd

force:

clean :
	rm -rf *.o work
