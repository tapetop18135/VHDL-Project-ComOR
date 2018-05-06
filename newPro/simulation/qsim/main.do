onerror {exit -code 1}
vlib work
vlog -work work main.vo
vlog -work work IR_ins_selc1_alu_selc2_control_mem_pc.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.IR_ins_selc1_alu_selc2_control_mem_pc_vlg_vec_tst -voptargs="+acc"
vcd file -direction main.msim.vcd
vcd add -internal IR_ins_selc1_alu_selc2_control_mem_pc_vlg_vec_tst/*
vcd add -internal IR_ins_selc1_alu_selc2_control_mem_pc_vlg_vec_tst/i1/*
run -all
quit -f
