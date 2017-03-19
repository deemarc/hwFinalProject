----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:01:24 03/18/2017 
-- Design Name: 
-- Module Name:    uartDecoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.lab02_pack.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uartDecoder is
    Port ( clk 		: in  STD_LOGIC;
           rst 		: in  STD_LOGIC;
           int_Rx 	: in  STD_LOGIC;
			  Data_in   : in  std_logic_vector(7 downto 0); --uart receive
			  Data_out  : out std_logic_vector(7 downto 0); -- uart send back
			  x_tick		: out std_logic_vector(11 downto 0); -- x position in term of tick
			  y_tick		: out std_logic_vector(11 downto 0)); -- y position in term of tick
           
end uartDecoder;

architecture Behavioral of uartDecoder is
type decodeState_type is (xl_st,xh_st,yl_st,yh_st);
signal decode_state : decodeState_type:=xl_st;
signal counter:integer range 0 to 255:=0;
signal x_data:std_logic_vector(11 downto 0):="000000000000";
signal y_data:std_logic_vector(11 downto 0):="000000000000";
begin

	process(rst,clk,int_Rx,Data_in)
	variable x_data_tmp:std_logic_vector(11 downto 0):="000000000000";
	variable y_data_tmp:std_logic_vector(11 downto 0):="000000000000";
	begin
		if rst = '1' then
			counter<=0;
			x_data_tmp:="000000000000";
			y_data_tmp:="000000000000";
			x_data<="000000000000";
			y_data<="000000000000";
		elsif rising_edge(int_rx) then
			if int_rx = '1' then
				case decode_state is
					when xl_st =>
						if Data_in(7 downto 6) = "00" then
							x_data_tmp(5 downto 0) := Data_in(5 downto 0);
							Data_out <= Data_in;
							decode_state <= xh_st;
						else
							Data_out <= "11111111"; -- error message
							--Data_out <= "11111111"; -- error message
							 -- ignore the upcoming x y and wait for the next one
							decode_state <= xl_st;
						end if;
					when xh_st =>
						if Data_in(7 downto 6) = "01" then
							x_data_tmp(11 downto 6) := Data_in(5 downto 0);
							Data_out <= Data_in;
							decode_state <= yl_st;
						else
							Data_out <= "11111111"; -- error message
							-- ignore the upcoming x y and wait for the next one
							decode_state <= xl_st;
						end if;
					when yl_st =>
						if Data_in(7 downto 6) = "10" then
							y_data_tmp(5 downto 0) := Data_in(5 downto 0);
							Data_out <= Data_in;
							decode_state <= yh_st;
						else
							Data_out <= "11111111"; -- error message
							-- ignore the upcoming x y and wait for the next one
							decode_state <= xl_st;
						end if;
					when yh_st =>
						decode_state <= xl_st; -- error or not we go there
						if Data_in(7 downto 6) = "11" then
							y_data_tmp(11 downto 6) := Data_in(5 downto 0);
							Data_out <= Data_in;
							x_data <= x_data_tmp;
							y_data <= y_data_tmp;
						else
							Data_out <= "11111111"; -- error message
						end if;
				end case;
			end if;
		end if;
		--Data_out <= std_logic_vector(to_unsigned(counter,8));
		x_tick <= x_data;
		y_tick <= y_data;
	end process;

end Behavioral;

