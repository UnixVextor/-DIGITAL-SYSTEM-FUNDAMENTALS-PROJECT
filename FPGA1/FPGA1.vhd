----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:08:11 12/11/2022 
-- Design Name: 
-- Module Name:    FPGA1 - Behavioral 
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

entity FPGA1 is
	port(
		up 			: in std_logic;
		down 			: in std_logic;
		left			: in std_logic;
		right 		: in std_logic;
		Switch 		: in std_logic;
		release		: in std_logic;
		o_up			: out std_logic;
		o_down		: out std_logic;
		o_left		: out std_logic;
		o_right		: out std_logic;
		o_switch		: out std_logic;
		o_release 	: out std_logic;
		LED 			: out std_logic_vector (5 downto 0)
	);
end FPGA1;

architecture Behavioral of FPGA1 is

begin
	
	o_up <= up and '1';
	o_down <= down and '1';
	o_left <= left and '1';
	o_right <= right and '1';
	o_switch <= Switch and '1';
	o_release <= release and '1';
	
	LED(5) <= up;
	LED(4) <= down;
	LED(3) <= right;
	LED(2) <= left;
	LED(1) <= Switch;
	LED(0) <= release;
	
end Behavioral;

