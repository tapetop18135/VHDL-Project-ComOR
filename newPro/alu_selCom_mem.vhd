library ieee;
use ieee.std_logic_1164.all;

entity alu_selCom_mem is
	port(
	
		clk , rst : in std_logic;
	
	-- in controller 
		in_opcode : in std_logic_vector(2 downto 0);
		
	-- in alu
		start_oper : in std_logic;
		in_A : in std_logic_vector(3 downto 0);
		in_B : in std_logic_vector(3 downto 0);
		
	-- out select_com
		sig_alu, sign_pc : out std_logic;		
		out_alu : out std_logic_vector(3 downto 0);
	
	
--	-- ram
--		data_in : in std_logic_vector(3 downto 0);
--		sig_slect_1 : in std_logic;
--		
--		sig_pc : out std_logic := '0';
--		data_out : out std_logic_vector(3 downto 0)
	
-- test
	test_con_mem : out std_logic_vector(1 downto 0); 
	test_sig_selec_mem :out std_logic;
	test_data_selec_mem :out std_logic_vector(3 downto 0)
	
	);
end entity;
architecture behev of alu_selCom_mem is
component controller is
	port(
		rst,clk : in std_logic;
		in_opcode : in std_logic_vector(2 downto 0);
		
		o_mem : out std_logic_vector(1 downto 0);
		o_one_instr ,o_select_1 ,o_select_2 ,o_alu : out std_logic_vector(2 downto 0)
		);
end component;
component alu is
		port(
		clk , rst : in std_logic;
		start_oper : in std_logic;
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
		in_reg : in integer range 0 to 16;
		in_controller : in std_logic_vector(2 downto 0);
		
		sig_alu, sig_mem, sign_pc : out std_logic;
--		out_alu : out integer range 0 to 16;
--		out_mem : out integer range 0 to 16
		
		out_alu : out std_logic_vector(3 downto 0);
		out_mem : out std_logic_vector(3 downto 0)
	);

end component;

--component ram is
--
--	port(
--		clk , rst : in std_logic;
--		data_in : in std_logic_vector(3 downto 0);
--		address : in std_logic_vector(3 downto 0);
--		start :in std_logic;
--		w_r : in std_logic_vector(1 downto 0);
--		
--		sig_pc : out std_logic := '0';
--		data_out : out std_logic_vector(3 downto 0)
--	);
--	
--end component;
	

signal temp_mem_con : std_logic_vector(1 downto 0);
signal temp_instr_con ,temp_select_1_con ,temp_select_2_con ,temp_alu_con : std_logic_vector(2 downto 0);

signal temp_sig_alu : std_logic;
signal temp_result_alu : integer range 0 to 15;

signal temp_sig_mem : std_logic;
signal temp_out_mem : std_logic_vector(3 downto 0);

begin
	u0 : controller
		port map(rst ,clk ,in_opcode ,temp_mem_con ,temp_instr_con ,temp_select_1_con ,temp_select_2_con ,temp_alu_con);
	u1 : alu 
		port map(clk ,rst ,start_oper ,in_A ,in_B ,temp_alu_con ,temp_sig_alu ,temp_result_alu);
	u2 : select_com
		port map(rst ,clk ,temp_sig_alu ,temp_result_alu ,temp_select_2_con ,sig_alu ,temp_sig_mem ,sign_pc ,out_alu ,temp_out_mem);
--	u3 : ram
--		port map(clk ,rst ,data_in ,temp_out_mem ,sig_slect_1 ,temp_mem_con ,sig_pc ,data_out);

	test_con_mem <= temp_mem_con;
	test_sig_selec_mem <= temp_sig_mem;
	test_data_selec_mem <= temp_out_mem;


end behev;