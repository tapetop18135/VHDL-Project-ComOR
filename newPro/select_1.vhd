library ieee;
use ieee.std_logic_1164.all;

entity select_1 is 
	port(
		rst,clk,in_fetch : in std_logic;
		in_reg_B : in std_logic_vector(3 downto 0);
		in_controller : in std_logic_vector(2 downto 0);
		
		sig_data_mem , sig_alu  : out std_logic;
		o_data_mem : out std_logic_vector(3 downto 0);
		o_alu : out std_logic_vector(3 downto 0)
	);
end entity;
architecture behev of select_1 is
	type stat_type is (start_st ,adder_st ,store_load_st );
	signal state : stat_type;
	signal temp_reg_B : std_logic_vector(3 downto 0);
	
	begin 
		process(clk,rst,in_fetch)
		begin	
			if(rst = '0')then
				sig_data_mem <= '0';
				sig_alu <= '0';
				o_data_mem <= "0000";
				o_alu <= "0000";
				state <= start_st;
				
			elsif(rising_edge(clk))then
				sig_alu <= '0';
				sig_data_mem <= '0';
				case state is 
					when start_st => 
						if(in_controller = "001")then
							state <= store_load_st;
						elsif(in_controller = "010")then
							state <= adder_st;
						end if;
					
					when store_load_st =>	
						if(in_fetch = '1')then
							sig_data_mem <= '1';
							o_data_mem <= in_reg_B;
							state <= start_st;
						end if;
						
					when adder_st =>
						if(in_fetch = '1')then
							sig_alu <= '1';
							o_alu <= in_reg_B;
							state <= start_st;
						end if;
					end case;
			end if;
		end process;
end behev;