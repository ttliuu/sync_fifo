import cocotb
from cocotb.clock import Timer

async def tick(dut):
    for cycle in range(10):
        dut.clk.value = 0
        await Timer(5, units="ns")
        dut.clk.value = 1
        await Timer(5, units="ns")

@cocotb.test()
async def test(dut):
    await cocotb.start(tick(dut))
    await Timer(5, units="ns")