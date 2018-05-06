library verilog;
use verilog.vl_types.all;
entity IR_ins_selc1_alu_selc2_control_mem_pc_vlg_check_tst is
    port(
        data_out        : in     vl_logic_vector(3 downto 0);
        t_data_outA     : in     vl_logic_vector(3 downto 0);
        t_data_outB     : in     vl_logic_vector(3 downto 0);
        t_opCode        : in     vl_logic_vector(2 downto 0);
        t_pc            : in     vl_logic_vector(3 downto 0);
        t_sig_pc        : in     vl_logic;
        test_out_ins    : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end IR_ins_selc1_alu_selc2_control_mem_pc_vlg_check_tst;
