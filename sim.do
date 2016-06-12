restart -f
mem load -i {C:/Modeltech_pe_edu_10.4a/examples/single plus/inst_branch.mem} -format mti /cpu/INSTCOM/memContent
mem load -filltype rand -filldata 1 -fillradix hexadecimal -skip 0 /cpu/DATACOM/memContent
mem load -filltype value -filldata 00000001 -fillradix hexadecimal /cpu/REGS/registers(8)
mem load -filltype value -filldata 00000001 -fillradix hexadecimal /cpu/REGS/registers(9)
mem load -filltype value -filldata 00000001 -fillradix hexadecimal /cpu/REGS/registers(10)
force -freeze sim:/cpu/nextAddr 8'h00 0 -cancel 10

force /cpu/clk 0 0, 1 5 -r 10

run 120