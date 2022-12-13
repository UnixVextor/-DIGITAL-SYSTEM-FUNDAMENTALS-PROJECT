----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:58:31 12/11/2022 
-- Design Name: 
-- Module Name:    FPGA2 - Behavioral 
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

entity FPGA2 is
	port(
			CLK				: in std_logic; 
			Xdirection 		: in std_logic_vector (1 downto 0);
			Zdirection 		: in std_logic_vector (1 downto 0);
			Bullet			: in std_logic;
			switch_motor	: in std_logic;
			motor				: out std_logic_vector (1 downto 0);
			Servo				: out std_logic_vector(2 downto 0)
			
	);	
end FPGA2;

architecture Behavioral of FPGA2 is

	-- servo Direction
	component servo_pwm is
	
		generic (
				value : integer
		);
		
		port(
				CLK 			: in std_logic;
				Direction 	: in std_logic_vector(1 downto 0);
				Qpwm			: out std_logic
		);
	
	end component;

	--servo bullet
	component servo_bullet is
		
		generic (
				value : positive
		);
	
		port(
				CLK 			: in std_logic;
				Control 		: in std_logic;
				Qpwm			: out std_logic
		);
	
	end component;


begin
	
	

	servoXDirectin : servo_pwm generic map(value => 50)
										port map(CLK, Xdirection, Servo(0));
	servoZDirectin : servo_pwm generic map(value => 80)
										port map(CLK, Zdirection, Servo(1));
	servoBullet		: servo_bullet generic map(value => 150)
											port map (CLK, Bullet, Servo(2));
	motor(0) <= switch_motor;
	motor(1) <= switch_motor;
	
end Behavioral;

