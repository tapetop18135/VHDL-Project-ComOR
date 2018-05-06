library verilog;
use verilog.vl_types.all;
entity IR_ins_selc1_alu_selc2_control_mem_pc_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start_but       : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end IR_ins_selc1_alu_selc2_control_mem_pc_vlg_sample_tst;
