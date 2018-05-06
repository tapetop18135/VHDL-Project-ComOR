library verilog;
use verilog.vl_types.all;
entity one_instruction_vlg_check_tst is
    port(
        o_reg_A         : in     vl_logic_vector(3 downto 0);
        o_reg_B         : in     vl_logic_vector(3 downto 0);
        o_sign          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end one_instruction_vlg_check_tst;
