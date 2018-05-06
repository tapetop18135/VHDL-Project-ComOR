library ieee;
use ieee.std_logic_1164.all;

entity one_instruction is
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

end entity;
architecture behev of one_instruction is
	type stat_type is (wait_st ,adder_st ,store_load_st , success_st);
	signal state : stat_type;
	
	signal tem_reg_C : std_logic_vector(3 downto 0);
	
	begin
		process(clk,rst,sign_ir)
		begin
		
			if(rst = '0')then
					o_sign <= '0';
					tem_reg_C <= "0000";
					o_reg_A <= "0000";
					o_reg_B <= "0000";
			elsif(rising_edge(clk))then
				o_sign <= '0';
				if(in_sign_temp_load = '1')then
					tem_reg_C <= in_temp_load;
				end if;
				if(in_sign_temp_mem = '1')then
					tem_reg_C <= in_temp_mem;
				end if;
				case state is 
					when wait_st =>
						if(in_controller = "001")then
							state <= store_load_st;
						elsif(in_controller = "010")then
							state <= adder_st;
						end if;
						
					when store_load_st =>
						if(sign_ir = '1')then
							o_sign <= '1';
							o_reg_A <= in_reg_A;
							o_reg_B <= tem_reg_C;
							state <= wait_st;
						end if;
						
					when adder_st =>
						if(sign_ir = '1')then
							o_sign <= '1';
							o_reg_A <= in_reg_A;
							o_reg_B <= in_reg_B;
							state <= wait_st;
						end if;
					
					when success_st =>
				end case;
			end if;
		end process;
end behev;