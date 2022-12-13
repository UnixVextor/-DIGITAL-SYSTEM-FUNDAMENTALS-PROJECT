----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:13:52 11/17/2022 
-- Design Name: 
-- Module Name:    servo_pwm - Behavioral 
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

entity servo_pwm is
	
	generic (
			value : integer := 50
	);
	
	port(
			CLK 			: in std_logic;
			Direction 	: in std_logic_vector(1 downto 0);
			Qpwm			: out std_logic
	);
	
end servo_pwm;


architecture Behavioral of servo_pwm is
		
	signal COUNT 		: integer range 0 to 2048;
	signal PWMPERIOD 	: integer range 0 to 300 := value; 
	
	signal clk100KHZ		: std_logic;
	signal clk10HZ			: std_logic;
	signal spwm				: std_logic;
	
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
				
				if (COUNT <= PWMPERIOD) then
					
						spwm <= '1';
				
				else
						
						spwm <= '0';
						
				end if;
				
			end if;
			
	end process;
	
	
	process (clk10HZ) 
		begin
		
			if rising_edge(clk10HZ) then
				
				if Direction(0) = '1' then
					
					
					if  PWMPERIOD > 250 then
					
						PWMPERIOD <= 250;
					
					end if;
					PWMPERIOD <= PWMPERIOD + 5;
				
				elsif Direction(1) = '1' then
				
					
					if  PWMPERIOD < 20 then
					
						PWMPERIOD <= 20;
					
					end if;
					
					PWMPERIOD <= PWMPERIOD - 5;
				else
				
					PWMPERIOD <= PWMPERIOD;
					
				end if;
				
			end if;
		
	end process;
	
	Qpwm <= spwm;
	
	CLOK100kHZ : div200HZ port map(CLK, clk100kHZ);
	CLOK10HZ	 : div2MHZ 	port map(CLK, clk10HZ);

end Behavioral;

