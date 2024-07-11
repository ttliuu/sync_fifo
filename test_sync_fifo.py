import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, Timer

async def reset(dut):
    await FallingEdge(dut.clk)
    dut.rst_n.value = 0
    await FallingEdge(dut.clk)
    dut.rst_n.value = 1
    dut.winc.value = 0
    dut.rinc.value = 0
    dut.wdata.value = 0
    await FallingEdge(dut.clk)

async def log(dut):
    dut._log.info(f"rdata = {hex(dut.rdata.value)}")
    dut._log.info(f"rempty = {hex(dut.rempty.value)}")
    dut._log.info(f"cnt = {hex(dut.cnt.value)}")
    dut._log.info(f"ram = {hex(dut.ram.value)}")


@cocotb.test()
async def test0(dut):
    cocotb.start_soon(Clock(dut.clk, 2, units="ns").start())
    await reset(dut)
    dut.winc.value = 1
    dut.wdata.value = 0xc0de
    await FallingEdge(dut.clk)
    dut.winc.value = 0
    dut.wdata.value = 0x0
    await log(dut)
    await FallingEdge(dut.clk)
    dut.rinc.value = 1
    await log(dut)
    await FallingEdge(dut.clk)
    dut.rinc.value = 0
    await log(dut)
    await FallingEdge(dut.clk)
    await log(dut)