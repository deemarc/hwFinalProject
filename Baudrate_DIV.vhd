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
use work.lab02_pack.all;
Entity Baudrate_div is
	generic(Bconst :baudrate_type:=(0,1302,2604,5208));  -- Bconst =   osc frequency/Baurdate
	port(clk 		:in std_logic;
	     rst 		:in std_logic;
		  sel : in  STD_LOGIC_VECTOR (1 downto 0);
		  baud_index : out integer range 0 to 3;
		  Baud_Div   :out std_logic);
end;
architecture RTL of Baudrate_div is
	signal Bdr_cnt : integer range 0 to Bconst(3);
begin	
process(rst,clk)
variable index:integer range 0 to 3:=0;	
begin
	if rst = '1' then
		Bdr_cnt <= 0;
		Baud_Div <= '0';
		index:= 0;
	elsif rising_edge(clk) then
		case sel is
			when "00" => index:=0;
			when "01" => index:=1;
			when "10" => index:=2;
			when "11" => index:=3;
			when others => index:=0;
		end case;
		if index = 0 then 
			Baud_Div <= '0';
			Bdr_cnt <= 0;
		elsif Bdr_cnt = Bconst(index)then
			Bdr_cnt <= 0;
			Baud_Div <= '1';
		else
			Bdr_cnt <= Bdr_cnt + 1;
			Baud_DIv <= '0';
		end if;
		baud_index <= index;
	end if;	
end process;
end;
