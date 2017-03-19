----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:43:23 02/07/2017 
-- Design Name: 
-- Module Name:    servoControl - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity servoControl is
    Port ( clk :in std_logic;
			  rst :in std_logic;
			  sel :in std_logic; -- selector
			  x_tick		: in std_logic_vector(11 downto 0); -- x position in term of tick
			  y_tick		: in std_logic_vector(11 downto 0); -- y position in term of tick
			  pwm_motor : out STD_LOGIC_VECTOR (1 downto 0));
end servoControl;

architecture Behavioral of servoControl is
	--From servo spec. Pwm cycle = 20 ms ,our clock periond = 20ns(50MHz)
	--Upper boundary at 180 degree: 2.3ms/20ns = 115 00
	
	constant period:integer:=1000000;
	constant upperB:integer:=100000;
	--Lower boundary 1ms/20ns = 50 000
	constant lowerB:integer:=50000;
	--define counter 
	signal counter,counter_next:integer:=0;
	--define duty cycle
	type duty_type is array (0 to 1) of integer;
	signal duty_cycle:duty_type:= (0,0);
	signal duty_cycle_next:duty_type:= (0,0);

	--define tick for indicate next PWM
	signal tick:std_logic;
	signal pwm_reg,pwm_next:STD_LOGIC_VECTOR(1 downto 0);
		
	type	 dutyArr is array(0 to 314) of integer range 50000 to 100000;
	constant arrayLength:integer:=314;
	signal arrIndex:integer:=0;

	
begin

	-- PWM Register
	process(clk,rst)
		 begin
			 if rst = '1' then 
				  --pwm_motor(0)<='0';
				  --pwm_motor(1)<='0';
				  counter<=0;
				  duty_cycle(0)<= 75000;
				  duty_cycle(1)<= 75000;
			 elsif clk='1' and clk'event then
				  pwm_reg(0)<=pwm_next(0);
				  pwm_reg(1)<=pwm_next(1);
				  counter<=counter_next;
				  duty_cycle(0)<=duty_cycle_next(0);
				  duty_cycle(1)<=duty_cycle_next(1);
			end if;
	end process;

	counter_next<= 0 when counter = period else counter+1;
	--tick indicate next PWM
	tick<= '1' when counter = 0 else '0';
	-- Duty cycle calculation
   process(tick, rst, sel,x_tick, y_tick )
		variable decodeXT:integer range 0 to 1000000:=0;
		variable decodeYT:integer range 0 to 1000000:=0;
		begin
			
			if rst = '1' then
				decodeXT:=0;
				decodeYT:=0;
			elsif tick='1' and tick'event then
				if sel = '1' then
					decodeXT:= to_integer(unsigned(x_tick))*50;
					if decodeXT > upperB then
						decodeXT:= upperB;
					end if;
					decodeYT:= to_integer(unsigned(y_tick))*50;
					if decodeYT > upperB then
						decodeYT:= upperB;
					end if;
				else
					decodeXT:=0;
					decodeYT:=0;
				end if;
			end if;
				
			duty_cycle_next(0) <= decodeXT;
			duty_cycle_next(1) <= decodeYT;
             
   end process;
	--Buffer
	pwm_motor(0)<=pwm_reg(0);
	pwm_motor(1)<=pwm_reg(1); 
	pwm_next(0)<= '1' when counter < duty_cycle(0) else
                         '0';
	pwm_next(1)<= '1' when counter < duty_cycle(1) else
                         '0';
								 
					


end Behavioral;

