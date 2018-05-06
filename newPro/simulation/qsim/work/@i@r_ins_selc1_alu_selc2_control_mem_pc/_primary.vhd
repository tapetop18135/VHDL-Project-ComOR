library verilog;
use verilog.vl_types.all;
entity IR_ins_selc1_alu_selc2_control_mem_pc is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start_but       : in     vl_logic;
        data_out        : out    vl_logic_vector(3 downto 0);
        t_data_outA     : out    vl_logic_vector(3 downto 0);
        t_data_outB     : out    vl_logic_vector(3 downto 0);
        t_opCode        : out    vl_logic_vector(2 downto 0);
        t_sig_pc        : out    vl_logic;
        t_pc            : out    vl_logic_vector(3 downto 0);
        test_out_ins    : out    vl_logic_vector(3 downto 0)
    );
end IR_ins_selc1_alu_selc2_control_mem_pc;
