library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
	port(
		clk , rst : in std_logic;
		start_mem,start_oper : in std_logic;
		in_A : in std_logic_vector(3 downto 0);
		in_B : in std_logic_vector(3 downto 0);
		op_code : in std_logic_vector(2 downto 0);
		
		sig_out : out std_logic := '0';
		result : out integer range 0 to 15 
	);

end entity;
architecture behev of alu is
	type stat_type is (start_st ,adder_st ,store_load_st , success_st );
	signal state : stat_type;
	signal temp_result : integer range 0 to 15 ;
	
	begin
		process(clk,rst,op_code)
		begin
		if(rst = '0')then
			result <= 0;
			sig_out <= '0';
			state <= start_st;
			temp_result <= 0;
			
		elsif(rising_edge(clk))then
			sig_out <= '0';
			case state is
				when start_st =>
					if(op_code = "001")then
						state <= store_load_st;
					elsif(op_code = "010")then
						state <= adder_st;
					end if;
					
				when store_load_st =>
					if(start_mem = '1')then
						temp_result <= conv_integer(in_A);
						state <= success_st;
					end if;
				
				when adder_st =>
					if(start_oper = '1')then
						temp_result <= conv_integer(in_A) + conv_integer(in_B);
						state <= success_st;
					end if;
				
				when success_st =>
					sig_out <= '1';
					result <= temp_result;
					state <= start_st;
				end case;
				
		end if;
	end process;
			
end behev;