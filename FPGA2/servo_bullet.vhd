----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:43:13 11/17/2022 
-- Design Name: 
-- Module Name:    servo_bullet - Behavioral 
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

entity servo_bullet is
	generic (
			value : integer := 150
	);
	
	port(
			CLK 			: in std_logic;
			Control 		: in std_logic;
			Qpwm			: out std_logic
	);
	
end servo_bullet;


architecture Behavioral of servo_bullet is
		
	signal COUNT 		: integer range 0 to 2048;
	signal PWMPERIOD 	: integer range 0 to 300 := value; 
	
	signal clk100KHZ		: std_logic;
	
	--signal clk10HZ			: std_logic;
	signal spwm				: std_logic_vector(1 downto 0);
	signal IsRelese		: std_logic := '0';
	signal IsFinish		: std_logic := '0';
	
	-- div 200 Hz Component
	component div200HZ is
		generic(
					fin 	: integer := 20000000;
					fout 	: integer := 100000 );
			
		port( 	CLK 	: in std_logic;
					Q		: out std_logic );
		
	end component;
	
	-- div 2M Hz Component
	component div2MHZ is
		
		generic(
					fin 	: integer := 20000000;
					fout	: integer := 10 ); 
	
		port(
					CLK 	: in 	std_logic;
					Q		: out std_logic );
					
	
	end component;

begin
	
	process (clk100kHZ) is
		begin
			
			if rising_edge(clk100kHZ) then
				
				if (COUNT >= 2000) then
						
						COUNT <= 0;
				else
						COUNT <= COUNT + 1;
				
				end if;
			
			end if;
		end process;
		
	process (clk100kHZ) is
		begin
			
			if rising_edge(clk100kHZ) then
				
				if (COUNT <= 75) then
					
						spwm(0) <= '1';
						
				else
				
						spwm(0) <= '0';
						
				end if;
				
				if (COUNT <= 40) then 
						
						spwm(1) <= '1';
				else
						
						spwm(1) <= '0';
				end if;
				
			end if;
			
	end process;
	


	
	
	with Control select
		Qpwm <= spwm(0) when '0',
				  spwm(1) when others;
				  
	CLOK100kHZ : div200HZ port map(CLK, clk100kHZ);

end Behavioral;
