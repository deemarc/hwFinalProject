--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;


package lab02_pack is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
	type baudrate_type is array(0 to 3) of integer range 0 to 5208;
	--type baudrate_type is array(0 to 3) of integer range 0 to 5208;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
	constant zero_seg 				: std_logic_vector(7 downto 0) := "11111110";-- a b c d e f g
	constant one_seg 					: std_logic_vector(7 downto 0) := "01100000";
	constant two_seg 					: std_logic_vector(7 downto 0) := "11011010";
	constant three_seg 				: std_logic_vector(7 downto 0) := "11110010";
	constant four_seg 				: std_logic_vector(7 downto 0) := "01100110";
	constant five_seg 				: std_logic_vector(7 downto 0) := "10110110";
	constant six_seg 					: std_logic_vector(7 downto 0) := "10111110";
	constant seven_seg 				: std_logic_vector(7 downto 0) := "11100000";
	constant eight_seg 				: std_logic_vector(7 downto 0) := "11111110";
	constant nine_seg 				: std_logic_vector(7 downto 0) := "11110110";
	constant off_seg 					: std_logic_vector(7 downto 0) := "00000000";


-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end lab02_pack;

package body lab02_pack is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end lab02_pack;
