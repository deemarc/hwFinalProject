----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:46:36 02/16/2017 
-- Design Name: 
-- Module Name:    uart_lab - Behavioral 
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
use work.lab02_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_lab is
generic(Bconst :baudrate_type:=(0,1302,2604,5208);
	        Bconst_div2:baudrate_type:=(0,561,1302,2604) );
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           WE_n : in  STD_LOGIC;
           RxD : in  STD_LOGIC;
           Int_Tx : out  STD_LOGIC;
           TxD : out  STD_LOGIC;
           --digit_scan : out  STD_LOGIC_VECTOR (3 downto 0);
           --seg7_out : out  STD_LOGIC_VECTOR (7 downto 0);
			  pwm_motor : out STD_LOGIC_VECTOR (1 downto 0);
           int_Rx : out  STD_LOGIC);
end uart_lab;

architecture Behavioral of uart_lab is
	component Baudrate_div
	generic(Bconst :baudrate_type:=(0,1302,2604,5208));
	port(clk 		:in std_logic;
	     rst 		:in std_logic;
		  sel 	: in  STD_LOGIC_VECTOR (1 downto 0);
		  baud_index : out integer range 0 to 3;
		  Baud_Div   :out std_logic);
	end component;
	component Transmitter 
	port(clk		: in std_logic;		 -- system clock
		 rst  	: in std_logic;			 -- active 'low' reset
		 Baud_Div 	: in std_logic;      -- Baudrate control signal
		 WE_n   	: in std_logic;		 -- active 'low' write enable
		 Data_in	: in std_logic_vector(7 downto 0); -- 8 bit input data
		 TxD    	: out std_logic;				   -- Transmit serial data
		 Int_Tx 	: out std_logic);				   -- Transmit interrupt 
	end component;
	
	component receiver 
	generic(Bconst :baudrate_type:=(0,1302,2604,5208);
	        Bconst_div2:baudrate_type:=(0,561,1302,2604));
	port(clk   : in std_logic;
	     rst   : in std_logic;
		 RxD   : in std_logic;
		 Baud_Div 	: in std_logic;     -- Baudrate control signal
		 baud_index : in  integer range 0 to 3;
		 Data_out   : out std_logic_vector(7 downto 0);
		 int_Rx     : out std_logic	);
	end component;
	component seg7_2digit 
	port( clk :in std_logic;
		  rst :in std_logic;
		  sel :in std_logic; -- selector
		  x_tick		: in std_logic_vector(11 downto 0); -- x position in term of tick
		  y_tick		: in std_logic_vector(11 downto 0); -- y position in term of tick
		  seg7_out :out std_logic_vector(7 downto 0);
		  digit_scan :out std_logic_vector(3 downto 0)
		);
	end component;
	component uartDecoder is
	Port ( clk 		: in  STD_LOGIC;
		  rst 		: in  STD_LOGIC;
		  int_Rx 	: in  STD_LOGIC;
		  Data_in   : in  std_logic_vector(7 downto 0); --uart receive
		  Data_out  : out std_logic_vector(7 downto 0); -- uart send back
		  x_tick		: out std_logic_vector(11 downto 0); --uart receive
		  y_tick		: out std_logic_vector(11 downto 0) --uart receive
		  );
	end component;
	
	component servoControl is
    Port ( clk :in std_logic;
			  rst :in std_logic;
			  sel	:in std_logic; -- selector
			  x_tick		: in std_logic_vector(11 downto 0); -- x position in term of tick
			  y_tick		: in std_logic_vector(11 downto 0); -- y position in term of tick
			  pwm_motor : out STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
signal Receive_Data:std_logic_vector(7 downto 0);
signal Baud_Div:std_logic;
signal Drx:std_logic_vector(7 downto 0);
signal Dtx:std_logic_vector(7 downto 0);
signal Dxtick:std_logic_vector(11 downto 0);
signal Dytick:std_logic_vector(11 downto 0);
signal DBxtick:std_logic_vector(11 downto 0);
signal DBytick:std_logic_vector(11 downto 0);
signal baud_index:integer range 0 to 3;
signal int_rxSig :STD_LOGIC;


begin

	u1:Baudrate_div port map(clk => clk ,
									rst => rst,
									sel => Data_in(1 downto 0),
									baud_index => baud_index,
									Baud_Div => Baud_Div);
	u2:uartDecoder port map(clk => clk,
								rst => rst,
								int_Rx => int_rxSig,
								Data_in => Drx,
								Data_out => Dtx,
								x_tick =>Dxtick,
								y_tick => Dytick);
	u3:receiver port map(clk => clk,
								rst => rst,
								RxD => RxD,
								Baud_Div => Baud_Div,
								baud_index => baud_index,
								Data_out => Drx,
								int_Rx => int_rxSig);
									
	u4:Transmitter port map(clk => clk,
									rst => rst,
									Baud_Div => Baud_Div,
									WE_n => int_rxSig,
									Data_in => Dtx,
									TxD => TxD,
									Int_Tx => Int_Tx);

	
								
--	u5:seg7_2digit port map(clk => clk,
--									rst => rst,
--									sel => Data_in(7),
--									x_tick =>Dxtick,
--									y_tick =>Dytick,
--									seg7_out => seg7_out,
--									digit_scan => digit_scan);
	
	u6:servoControl port map(clk => clk,
									rst => rst,
									sel => Data_in(6),
									x_tick =>Dxtick,
									y_tick =>Dytick,
									pwm_motor=>pwm_motor);	
--	DBxtick<=Dxtick;
--	DBytick<=Dytick;
	int_Rx <= int_rxSig;
end Behavioral;

