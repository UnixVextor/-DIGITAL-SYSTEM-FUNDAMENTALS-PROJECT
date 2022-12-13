----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:51:07 11/17/2022 
-- Design Name: 
-- Module Name:    div200HZ - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity div200HZ is
	generic(
				fin 	: integer := 20000000;
				fout 	: integer := 100000 );
		
	port( 	CLK 	: in std_logic;
				Q		: out std_logic );
	
end div200HZ;


architecture Behavioral of div200HZ is

	signal COUNT : integer range 0 to (fin/fout);
	signal qs 	 : std_logic := '0';
	
begin
	
	process (CLK)
		begin
			if rising_edge(CLK) then
				
				if (COUNT >= (fin/fout)) then
					
					COUNT <= 0;
					qs <= not(qs);
				
				else
					
					COUNT <= COUNT + 1;
				
				end if;
				
			end if; 
	end process;
	
	Q <= qs;
	
end Behavioral;	

