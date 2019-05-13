library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY PUSH_BUTTONS IS
	PORT(	PB_1 : IN STD_LOGIC;
			CLOCK : IN STD_LOGIC;
			PUSH_BUTTON_1	: OUT	STD_LOGIC);
END ENTITY PUSH_BUTTONS;

architecture Behavior of PUSH_BUTTONS is
SIGNAL TOGGLE_BUTTON_1   :STD_LOGIC := '1';
begin

PUSH_BUTTON_1 <= not PB_1;
--PROCESS(CLOCK) 
--	VARIABLE SWITCH : STD_LOGIC;
--BEGIN

--IF (RISING_EDGE(CLOCK)) THEN
--	IF (PB_1 = '0') THEN
--		IF(SWITCH = '0') THEN
--			TOGGLE_BUTTON_1 <= NOT TOGGLE_BUTTON_1;
--			SWITCH := '1';
--		END IF;
--	ELSE
--		SWITCH := '0';
--	END IF;
--END IF;
--END PROCESS;
--PUSH_BUTTON_1 <= TOGGLE_BUTTON_1;
end Behavior;