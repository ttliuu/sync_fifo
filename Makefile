# Makefile

TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(shell pwd)/sync_fifo.sv
TOPLEVEL = sync_fifo
MODULE = test_sync_fifo

include $(shell cocotb-config --makefiles)/Makefile.sim
