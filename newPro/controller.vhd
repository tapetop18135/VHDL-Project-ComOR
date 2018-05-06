library ieee;
use ieee.std_logic_1164.all;

entity controller is
	port(
		rst,clk : in std_logic;
		in_opcode : in std_logic_vector(2 downto 0);
		
		o_mem : out std_logic_vector(1 downto 0);
		o_one_instr ,o_select_1 ,o_select_2 ,o_alu : out std_logic_vector(2 downto 0)
		);
end entity;
architecture behev of controller is
	type stat_type is (wait_st ,adder_st ,store_st ,load_st);
	signal state : stat_type;
	
	begin
		process(clk,rst)
		begin
			if(rst = '0')then
				o_mem <= "00";
				o_select_1 <= "000";
				o_select_2 <= "000";
				o_alu <= "000";
				o_one_instr <= "000";
				state <= wait_st;
			elsif(rising_edge(clk))then
				o_mem <= "00";
				o_select_1 <= "000";
				o_select_2 <= "000";
				o_alu <= "000";
				o_one_instr <= "000";
				case state is
					when	wait_st => 
						if(in_opcode = "001")then
							state <= store_st;
						elsif(in_opcode = "010")then 
							state <= adder_st;
						elsif(in_opcode = "100")then 
							state <= load_st;
						end if;
						
					when store_st =>
						o_mem <= "01";
						o_select_1 <= "001";
						o_select_2 <= "001";
						o_alu <= "001";
						o_one_instr <= "001";
						state <= wait_st;
						
					when load_st =>
						o_mem <= "10";
						o_select_1 <= "001";
						o_select_2 <= "001";
						o_alu <= "001";
						o_one_instr <= "001";
						state <= wait_st;

					when adder_st =>
						o_mem <= "00";
						o_select_1 <= "010";
						o_select_2 <= "010";
						o_alu <= "010";
						o_one_instr <= "010";
						state <= wait_st;
					
				end case;
			end if;
		end process;
end behev;