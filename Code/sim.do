vsim -gui work.cpu(arch)
# vsim -gui work.cpu(arch) 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.cpu(arch)
# Loading work.my_ndff(b_my_ndff)
# Loading work.my_dff(a_my_dff)
# Loading work.tri_state_buffer(arch)
# Loading ieee.numeric_std(body)
# Loading work.ram(syncrama)
# Loading work.alsu(arch)
# Loading work.parta(arch4)
# ** Warning: (vsim-3473) Component instance "u0 : my_nadder" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /cpu/ALSU_comp/u0 File: C:/altera/14.0/Project/PartA.vhd
# Loading work.partb(arch1)
# Loading work.partc(arch2)
# Loading work.partd(arch3)
# Loading work.cu(arch)
# Loading work.decoding_circuit(d_circuit)
# Loading work.pla(ar_generate)
# Loading work.bitoring(struct)
# Loading work.rom(rom_arch)
# Loading work.my_4x16decoder(a_my_4x16decoder)
# Loading work.my_3x8decoder(a_my_3x8decoder)
# Loading work.my_2x4decoder(a_my_2x4decoder)

add wave  \
sim:/cpu/data_bus \
sim:/cpu/CLK \
sim:/cpu/internal_CLK \
sim:/cpu/RST 
add wave  \
sim:/cpu/CU_comp/uAR \
sim:/cpu/CU_comp/CW 
add wave  \
sim:/cpu/R0 \
sim:/cpu/R1 \
sim:/cpu/R2 \
sim:/cpu/PC \
sim:/cpu/address \
sim:/cpu/MDR \
sim:/cpu/mem_data \
sim:/cpu/IR \
sim:/cpu/Z \
sim:/cpu/Y \
sim:/cpu/SRC \
sim:/cpu/DST \
sim:/cpu/TMP \
sim:/cpu/ALSU_out \
sim:/cpu/ALSU_Flags \
sim:/cpu/FLAGS \
sim:/cpu/MDR_E \
sim:/cpu/MFC \
sim:/cpu/MDR_input \
sim:/cpu/Cout \
sim:/cpu/Zero \
sim:/cpu/Negative \
sim:/cpu/Overflow \
sim:/cpu/Y_RST \
sim:/cpu/R0in \
sim:/cpu/R0out \
sim:/cpu/R1in \
sim:/cpu/R1out \
sim:/cpu/R2in \
sim:/cpu/R2out \
sim:/cpu/PCout \
sim:/cpu/MDRout \
sim:/cpu/Zout \
sim:/cpu/SRCout \
sim:/cpu/DSTout \
sim:/cpu/TMPout \
sim:/cpu/PCin \
sim:/cpu/IRin \
sim:/cpu/Zin \
sim:/cpu/MARin \
sim:/cpu/MDRin \
sim:/cpu/TMPin \
sim:/cpu/Yin \
sim:/cpu/SRCin \
sim:/cpu/DSTin \
sim:/cpu/ALSUin \
sim:/cpu/R \
sim:/cpu/W \
sim:/cpu/HLT \
sim:/cpu/ClearY \
sim:/cpu/Carryin \
sim:/cpu/FLAGS_E 

force -freeze sim:/cpu/RST 1 0
force -freeze sim:/cpu/CLK 0 0, 1 {50 ps} -r 100

run
force -freeze sim:/cpu/RST 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run