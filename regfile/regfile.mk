GHDL=ghdl
GHDLFLAGS=--ieee=standard --workdir=work
GHDLRUNFLAGS=--vcd=regfile.vcd --stop-time=800ns

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e regfile_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) regfile_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) regfile.vhd
	$(GHDL) -a $(GHDLFLAGS) regfile_tb.vhd

force:

clean :
	rm -rf *.o work
