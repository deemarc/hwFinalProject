-- -----------------------------------
--     Baudrate divider
-- File name: baudrate_div.vhd
-- -----------------------------------
-- designer : Janwit Sriharuksa
-- Date     : 9th/May/2002
-- -----------------------------------
--
library ieee;
use ieee.std_logic_1164.all;
Entity Baudrate_div is
	generic(Bconst :baudrate_type:=(0,1302,2604,5208));
	port(clk 		:in std_logic;
	     rst 		:in std_logic;
		  Data_in 	:in  STD_LOGIC_VECTOR (1 downto 0);
		  Data_out : in  STD_LOGIC_VECTOR (1 downto 0);
		  Baud_Div   :out std_logic);
end;
architecture RTL of Baudrate_div is
	signal Bdr_cnt : integer range 0 to Bconst;
begin	
process(rst,clk)
variable index:integer range 0 to 3;	
begin
	if rst = '1' then
		Bdr_cnt <= 0;
		Baud_Div <= '0';		
	elsif rising_edge(clk) then
		case Data_in is 
			when "00" =>
				index:=0;
			when "00" =>
				index:=1;
			when "00" =>
				index:=2;
			when "11" =>
				index:=3;
		end case;
		if Bdr_cnt = Bconst then
			Bdr_cnt <= 0;
			Baud_Div <= '1';
		else
			Bdr_cnt <= Bdr_cnt + 1;
			Baud_DIv <= '0';
		end if;
	end if;	
end process;
end;
