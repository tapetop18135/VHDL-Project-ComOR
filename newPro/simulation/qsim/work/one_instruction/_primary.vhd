library verilog;
use verilog.vl_types.all;
entity one_instruction is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sign_ir         : in     vl_logic;
        in_controller   : in     vl_logic_vector(2 downto 0);
        in_reg_A        : in     vl_logic_vector(3 downto 0);
        in_reg_B        : in     vl_logic_vector(3 downto 0);
        in_sign_temp_mem: in     vl_logic;
        in_temp_mem     : in     vl_logic_vector(3 downto 0);
        in_sign_temp_load: in     vl_logic;
        in_temp_load    : in     vl_logic_vector(3 downto 0);
        o_sign          : out    vl_logic;
        o_reg_A         : out    vl_logic_vector(3 downto 0);
        o_reg_B         : out    vl_logic_vector(3 downto 0)
    );
end one_instruction;
