library ieee;
use ieee.std_logic_1164.all;

entity IR_ins_selc1_alu_selc2_control_mem_pc is
	port(
	
		clk,rst :in std_logic;
		start_but :in std_logic;
		
		data_out : out std_logic_vector(3 downto 0);
		
		
		-- test
		
		t_data_outA,t_data_outB :out std_logic_vector(3 downto 0);
		t_opCode : out std_logic_vector(2 downto 0);
		t_sig_pc : out std_logic;
		t_pc : out integer range 0 to 15;
		
		test_out_ins : out std_logic_vector(3 downto 0)
	);
	
end entity;
architecture behev of IR_ins_selc1_alu_selc2_control_mem_pc is
component one_instruction is
	port(
		clk,rst,sign_ir :in std_logic;
		in_controller : std_logic_vector(2 downto 0);
		in_reg_A ,in_reg_B : in std_logic_vector(3 downto 0);
		
		in_sign_temp_mem : in std_logic;
		in_temp_mem : in std_logic_vector(3 downto 0);
		
		in_sign_temp_load : in std_logic;
		in_temp_load : in std_logic_vector(3 downto 0);
		
		o_sign : out std_logic;
		o_reg_A ,o_reg_B : out std_logic_vector(3 downto 0)
		
	);

end component;
component select_1 is
	port(
		rst,clk,in_fetch : in std_logic;
		in_reg_B : in std_logic_vector(3 downto 0);
		in_controller : in std_logic_vector(2 downto 0);
		
		sig_data_mem , sig_alu  : out std_logic;
		o_data_mem : out std_logic_vector(3 downto 0);
		o_alu : out std_logic_vector(3 downto 0)
	);
end component;


component alu is
	port(
		clk , rst : in std_logic;
		start_mem ,start_oper : in std_logic;
		in_A : in std_logic_vector(3 downto 0);
		in_B : in std_logic_vector(3 downto 0);
		op_code : in std_logic_vector(2 downto 0);
		
		sig_out : out std_logic := '0';
		result : out integer range 0 to 15 
	);
end component;

component select_com is
	port(
		rst,clk,in_alu : in std_logic;
		in_reg : in integer range 0 to 15;
		in_controller : in std_logic_vector(2 downto 0);
		
		sig_alu, sig_mem, sign_pc : out std_logic;
		
		out_alu : out std_logic_vector(3 downto 0);
		out_mem : out std_logic_vector(3 downto 0)
	);
end component;
component controller is
port(
		rst,clk : in std_logic;
		in_opcode : in std_logic_vector(2 downto 0);
		
		o_mem : out std_logic_vector(1 downto 0);
		o_one_instr ,o_select_1 ,o_select_2 ,o_alu : out std_logic_vector(2 downto 0)
		);
end component;
component ram is
port(
		clk , rst : in std_logic;
		data_in : in std_logic_vector(3 downto 0);
		address : in std_logic_vector(3 downto 0);
		start :in std_logic;
		w_r : in std_logic_vector(1 downto 0);
		
		sig_pc : out std_logic := '0';
		data_out : out std_logic_vector(3 downto 0)
	);
end component;

component pc is
port(
	clk,rst,start_but,sign_in_alu,sign_in_mem : in std_logic;
	
	sign_o : out std_logic;
	pc_o : out integer range 0 to 15
);
end component;

component IR is
	port(
		rst,clk,in_sign : std_logic;
		in_pc : in integer range 0 to 15;
--		

		sign_out : out std_logic;
		o_reg_A ,o_reg_B : out std_logic_vector(3 downto 0);
		o_opcode : out std_logic_vector(2 downto 0)
	);
end component;

-- controller 
signal temp_wr_con : std_logic_vector(1 downto 0);
signal temp_instr ,temp_select_1 ,temp_select_2 ,temp_alu : std_logic_vector(2 downto 0);
-- one_instruction
signal temp_one_inst_sign : std_logic;
signal temp_one_inst_reg_A ,temp_one_inst_reg_B : std_logic_vector(3 downto 0);
-- select_1
signal temp_sign_alu_slc1 ,temp_sign_mem_slc1 :std_logic;
signal temp_data_alu_slc1 ,temp_data_mem_slc1 :std_logic_vector(3 downto 0);
-- alu
signal temp_sign_alu :std_logic;
signal temp_result_alu :integer range 0 to 15;
-- select_com
signal temp_sign_alu_inst_selc2 ,temp_sign_address_mem_selc2 ,temp_sign_pc_select2 :std_logic;
signal temp_data_alu_inst_selc2 ,temp_address_mem_selc2 :std_logic_vector(3 downto 0);
-- ram
signal temp_sign_pc_ram : std_logic;
signal temp_data_ram_instr : std_logic_vector(3 downto 0);
-- pc
signal temp_sign_pc_IR : std_logic;
signal tmep_integer_pc_IR : integer range 0 to 15;
-- IR 
signal temp_sign_IR_instruction : std_logic;
signal temp_regA_IR_instruction ,temp_regB_IR_instruction : std_logic_vector(3 downto 0);
signal temp_opcode_IR_instruction : std_logic_vector(2 downto 0);

begin
	U0	: IR
		port map(rst ,clk ,temp_sign_pc_IR ,tmep_integer_pc_IR ,temp_sign_IR_instruction ,temp_regA_IR_instruction ,temp_regB_IR_instruction ,temp_opcode_IR_instruction);
	U1 : controller
		port map(rst ,clk ,temp_opcode_IR_instruction ,temp_wr_con ,temp_instr ,temp_select_1 ,temp_select_2 ,temp_alu);
	U2 : one_instruction
		port map(clk ,rst ,temp_sign_IR_instruction ,temp_instr ,temp_regA_IR_instruction ,temp_regB_IR_instruction ,temp_sign_alu_inst_selc2 ,temp_data_alu_inst_selc2 ,temp_sign_pc_ram,temp_data_ram_instr,temp_one_inst_sign ,temp_one_inst_reg_A ,temp_one_inst_reg_B);
	U3 : select_1
		port map(rst ,clk ,temp_one_inst_sign ,temp_one_inst_reg_B ,temp_select_1 ,temp_sign_mem_slc1 ,temp_sign_alu_slc1 ,temp_data_mem_slc1 ,temp_data_alu_slc1);
	U4 : alu
		port map(clk ,rst ,temp_one_inst_sign ,temp_sign_alu_slc1 ,temp_one_inst_reg_A ,temp_data_alu_slc1 ,temp_alu ,temp_sign_alu ,temp_result_alu);
	U5 : select_com
		port map(rst ,clk ,temp_sign_alu ,temp_result_alu ,temp_select_2 ,temp_sign_alu_inst_selc2 ,temp_sign_address_mem_selc2 ,temp_sign_pc_select2 ,temp_data_alu_inst_selc2 ,temp_address_mem_selc2);
	U6 : ram
		port map(clk ,rst ,temp_data_mem_slc1 ,temp_address_mem_selc2 ,temp_sign_address_mem_selc2 ,temp_wr_con ,temp_sign_pc_ram ,temp_data_ram_instr);
	U7 : pc
		port map(clk ,rst ,start_but ,temp_sign_pc_select2 ,temp_sign_pc_ram ,temp_sign_pc_IR ,tmep_integer_pc_IR);
	
	test_out_ins <= temp_one_inst_reg_B;
	data_out <= temp_data_ram_instr;
	t_data_outA <= temp_one_inst_reg_A;
	t_data_outB <= temp_one_inst_reg_B;
	t_opCode <= temp_instr;
	t_sig_pc <= temp_sign_pc_IR;
	t_pc <= tmep_integer_pc_IR;
	
--	o_mem <= temp_wr_con;
--	o_one_instr <= temp_instr;
--	o_select_1 <= temp_select_1;
--	o_select_2 <= temp_select_2;
--	o_alu <= temp_alu;
end behev;