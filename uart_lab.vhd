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
	     Bconst_div2 :baudrate_type:=(0,561,1302,2404));
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Data_in : in  STD_LOGIC_VECTOR (1 downto 0);
           WE_n : in  STD_LOGIC;
           RxD : in  STD_LOGIC;
           Int_Tx : out  STD_LOGIC;
           TxD : out  STD_LOGIC;
           digit_scan : out  STD_LOGIC_VECTOR (3 downto 0);
           seg7_out : out  STD_LOGIC_VECTOR (7 downto 0);
           int_Rx : out  STD_LOGIC);
end uart_lab;

architecture Behavioral of uart_lab is
	component Baudrate_div
	generic(Bconst :baudrate_type:=(0,1302,2604,5208));
	port(clk 		:in std_logic;
	     rst 		:in std_logic;
		  Data_in : in  STD_LOGIC_VECTOR (1 downto 0);
		  Data_out : out integer range 0 to 3;
		  Baud_Div   :out std_logic);
	end component;
	component Transmitter 
	port(clk		: in std_logic;		 -- system clock
		 rst  	: in std_logic;			 -- active 'low' reset
		 Baud_Div: in std_logic;      -- Baudrate control signal
		 WE_n   	: in std_logic;		 -- active 'low' write enable
		 Data_in	: in std_logic_vector(1 downto 0); -- 8 bit input data
		 TxD    	: out std_logic;				   -- Transmit serial data
		 Int_Tx 	: out std_logic);				   -- Transmit interrupt 
	end component;
	
	component receiver 
	generic(Bconst :baudrate_type:=(0,1302,2604,5208);
	     Bconst_div2 :baudrate_type:=(0,561,1302,2404));
	port(clk   : in std_logic;
	     rst   : in std_logic;
		 RxD   : in std_logic;
		 Baud_Div 	: in std_logic;     -- Baudrate control signal
		 Data_out   : out std_logic_vector(7 downto 0);
		 int_Rx     : out std_logic	);
	end component;
	component seg7_2digit 
	port( clk :in std_logic;
		  rst :in std_logic;
		  Din :in std_logic_vector(1 downto 0);
		  digit_scan :out std_logic_vector(3 downto 0);
		  seg7_out :out std_logic_vector(7 downto 0)
		);
	end component;
	
signal Receive_Data:std_logic_vector(7 downto 0);
signal Baud_Div:std_logic;
signal baud_sel:integer range 0 to 3;


begin
port(clk 		:in std_logic;
	     rst 		:in std_logic;
		  Data_in : in  STD_LOGIC_VECTOR (1 downto 0);
		  Data_out : out integer range 0 to 3;
		  Baud_Div   :out std_logic);
	u2:Baudrate_div port map(clk => clk ,
									rst => rst,
									Data_in => Data_in,
									Data_out => baud_sel,
									Baud_Div => Baud_Div);
									
	u3:Transmitter port map(clk => clk,
									rst => rst,
									Baud_Div => Baud_Div,
									WE_n => WE_n,
									Data_in => Data_in,
									TxD => TxD,
									Int_Tx => Int_Tx);
	u4:receiver port map(clk => clk,
								rst => rst,
								RxD => RxD,
								Baud_Div => Baud_Div,
								Data_out => Din,
								int_Rx => int_Rx);
	u5:seg7_2digit port map(clk,rst,Din,digit_scan,seg7_out);

end Behavioral;

