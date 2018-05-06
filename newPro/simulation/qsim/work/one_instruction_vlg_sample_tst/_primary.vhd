library verilog;
use verilog.vl_types.all;
entity one_instruction_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        in_controller   : in     vl_logic_vector(2 downto 0);
        in_reg_A        : in     vl_logic_vector(3 downto 0);
        in_reg_B        : in     vl_logic_vector(3 downto 0);
        in_sign_temp_load: in     vl_logic;
        in_sign_temp_mem: in     vl_logic;
        in_temp_load    : in     vl_logic_vector(3 downto 0);
        in_temp_mem     : in     vl_logic_vector(3 downto 0);
        rst             : in     vl_logic;
        sign_ir         : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end one_instruction_vlg_sample_tst;
