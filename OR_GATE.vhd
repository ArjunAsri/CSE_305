--The OR_GATE entity is used to make it easier to connect buses to the or gate. This 
--also provide flexibility when we have more components resulting in more RGB values

library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY OR_GATE IS
	PORT(	INPUT_1, INPUT_2, INPUT_3, INPUT_4, INPUT_5, INPUT_6: IN	STD_LOGIC_VECTOR (3 DOWNTO 0);
			OUTPUT_1	: OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
END OR_GATE;

architecture Behavior of OR_GATE is
begin
   
OUTPUT_1 <= INPUT_1 OR INPUT_2 OR INPUT_3 OR INPUT_4 OR INPUT_5 OR INPUT_6;
end Behavior;