TOPLEVEL_LANG ?= verilog

PWD=$(shell pwd)

VERILOG_SOURCES += $(PWD)/sync_fifo.sv

TOPLEVEL := sync_fifo
MODULE   := test_sync_fifo

include $(shell cocotb-config --makefiles)/Makefile.sim
