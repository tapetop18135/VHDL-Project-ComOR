library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity select_com is
	port(
		rst,clk,in_alu : in std_logic;
		in_reg : in integer range 0 to 15;
		in_controller : in std_logic_vector(2 downto 0);
		
		sig_alu, sig_mem, sign_pc : out std_logic;
--		out_alu : out integer range 0 to 16;
--		out_mem : out integer range 0 to 16
		
		out_alu : out std_logic_vector(3 downto 0);
		out_mem : out std_logic_vector(3 downto 0)
	);

end entity;
architecture behev of select_com is
	type stat_type is (start_st ,adder_st ,store_load_st );
	signal state : stat_type;
	begin
		process(clk,in_controller,in_alu)
		begin 
			if(rst = '0')then
				sig_mem <= '0';
				sign_pc <= '0';
				sig_alu <= '0';
--				out_alu <= 0;
--				out_mem <= 0;
				out_alu <= "0000";
				out_mem <= "0000";
				state <= start_st;
				
			elsif(rising_edge(clk))then
				sign_pc <= '0';
				case state is
				when start_st =>
					sig_alu <= '0';
					sig_mem <= '0';
					if(in_controller = "001")then
						state <= store_load_st;
					elsif(in_controller = "010")then
						state <= adder_st;
					end if;
				
				when store_load_st =>
					if(in_alu = '1')then
--						out_mem <= in_reg;
						out_mem <= conv_std_logic_vector(in_reg, out_mem'length);
						sig_mem <= '1';
						state <= start_st;
					end if;
				
				when adder_st => 
					if(in_alu = '1')then
--						out_alu <= in_reg;
						out_alu <= conv_std_logic_vector(in_reg, out_alu'length);
						sig_alu <= '1';
						sign_pc <= '1';
						state <= start_st;
					end if;
				end case;
					
			end if;
		end process;
end behev;
 