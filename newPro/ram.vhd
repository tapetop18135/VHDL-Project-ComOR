library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity ram is
	port(
		clk , rst : in std_logic;
		data_in : in std_logic_vector(3 downto 0);
		address : in std_logic_vector(3 downto 0);
		start :in std_logic;
		w_r : in std_logic_vector(1 downto 0);
		
		sig_pc : out std_logic := '0';
		data_out : out std_logic_vector(3 downto 0)
		
	);
	
end entity; 
architecture bev of ram is
	type mem is array (0 to 15) of std_logic_vector(3 downto 0);
	signal memory : mem ;
	
	type stat_type is (start_st ,store_address_st , store_data_st ,load_address_st , load_data_st , success_st);
	signal state : stat_type;
	
	signal addr : integer range 0 to 15;
	
	
	begin
		process(clk,rst,w_r,start)
		begin
			if(rst = '0')then
				data_out <= "0000";
				addr <= 0;
				sig_pc <= '0';
				state <= start_st;
				
			elsif(rising_edge(clk))then
				
				sig_pc <= '0';
				case state is
					when  start_st =>
						
						if(w_r = "01") then
							state <= store_address_st;
						elsif(w_r = "10")then
							state <= load_address_st;
						end if;
					
					when store_address_st => 
						if(start = '1')then
							addr <= conv_integer(address);
							state <= store_data_st;
						end if;
					
					when store_data_st =>
						memory(addr) <= data_in;
						state <= success_st;
					
					when load_address_st =>
						if(start = '1')then
							addr <= conv_integer(address);
							state <= load_data_st;
						end if;
					
					when load_data_st =>
						data_out <= memory(addr);
						state <= success_st;
					
					when success_st =>
						sig_pc <= '1';
						state <= start_st;
				end case;
			end if;
		end process;
		
end bev;