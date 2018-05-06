library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity IR is
	port(
		rst,clk,in_sign : std_logic;
		in_pc : in integer range 0 to 15;
--			
--		data_integer : out integer range 0 to 15;
--		data_11 : out std_logic_vector(10 downto 0)
		
		sign_out : out std_logic;
		o_reg_A ,o_reg_B : out std_logic_vector(3 downto 0);
		o_opcode : out std_logic_vector(2 downto 0)
	);
	
end entity;
architecture behev of IR is
	type mem is array (0 to 8) of std_logic_vector(10 downto 0);
	signal memory : mem := 
	(
	 -- opcode   regA  regB
	 --  3 bit   4bit  4bit
	 -- opcode 
	 -- 010 for add
	 -- 001 for store
	 -- 100 for load
	 
	 -- code 
	 "01000110010", -- 0  add    0011(3) 0010(2) 
	 "00100011111", -- 1  store  0001(1) 
	 "01001010111", -- 2  add    0101(5) 0111(7) 
	 "00100001111", -- 3  store  0000(0)
	 "10000011111", -- 4  load   0001(1)
	 "00110001111", -- 5  store  1000(8)
	 "10000011111", -- 6  load   0001(1)
	 "10000001111", -- 7  load   0000(0)
	 "10010001111"  -- 8  load 	 0011(8) 
	);
	
	type stat_type is (wait_pc , orgnize_data ,fetch_opcode ,buffer_st ,buffer_st2 ,fetch_data);
	signal state : stat_type;
		
	signal temp_assambly : std_logic_vector(10 downto 0); 
	signal temp_opcode : std_logic_vector(2 downto 0);
	signal temp_reg_A ,temp_reg_B :std_logic_vector(3 downto 0):= "0000";
	
	begin
		process(clk,rst,in_sign)
		begin
			if(rst = '0')then
				o_reg_A <= "0000";
				o_reg_B <= "0000";
				o_opcode <= "000";
				temp_opcode <= "000";
				temp_reg_A <= "0000";
				temp_reg_B <= "0000";
				state <= wait_pc;
			elsif(rising_edge(clk))then
				sign_out <= '0';
				o_opcode <= "000";
				case state is
					when wait_pc =>
						if(in_sign = '1')then
							temp_assambly <= memory(in_pc);
							state <= orgnize_data;
						end if;
						
					when orgnize_data =>
						temp_opcode <= temp_assambly(10 downto 8);
						temp_reg_A <= temp_assambly(7 downto 4);
						temp_reg_B <= temp_assambly(3 downto 0);
						state <= fetch_opcode;
					
					when fetch_opcode	=>
						o_opcode <= temp_opcode;
						state <= buffer_st;
					
					when buffer_st =>
						state <= buffer_st2;
						
					when buffer_st2 =>
						state <= fetch_data;
					
					when fetch_data =>
						sign_out <= '1';
						o_reg_A <= temp_reg_A;
						o_reg_B <= temp_reg_B;
						state <= wait_pc;
						
					end case;
			end if;	
		end process;
end behev;