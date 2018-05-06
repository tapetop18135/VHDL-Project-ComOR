library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc is
port(
	clk,rst,start_but,sign_in_alu,sign_in_mem : in std_logic;
	
	sign_o : out std_logic;
	pc_o : out integer range 0 to 15
);
end entity;

architecture behev of pc is
	type stat_type is (start_pro ,wait_sign ,add_pc , success_st );
	signal state : stat_type := start_pro;
	signal temp_pc : integer range 0 to 15;
	begin
		process(clk,rst,sign_in_alu,sign_in_mem)
		begin 
			if(rst = '0')then
				pc_o <= 0;
				temp_pc <= 0;
				sign_o <= '0';
				state <= start_pro;
			elsif(rising_edge(clk))then
				
				sign_o <= '0';
				case state is
					when start_pro =>
						if(start_but = '1')then
							sign_o <= '1';
							pc_o <= 0;
							state <= wait_sign;
						end if;
					
					when wait_sign =>
						if(sign_in_alu = '1' or sign_in_mem = '1')then
							state <= add_pc;
						end if;
						
					when add_pc =>
						if(temp_pc = 8)then
							temp_pc <= 0;
							state <= start_pro;
						else 
							temp_pc <= temp_pc + 1;
							state <= success_st;
						end if;
						
					when success_st =>
						pc_o <= temp_pc;
						sign_o <= '1';
						state <= wait_sign;
				end case;
			end if;
		end process;
						
end behev;