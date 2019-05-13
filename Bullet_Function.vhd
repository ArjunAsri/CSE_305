LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

ENTITY BULLET_FUNCTION IS 
PORT ( SIGNAL MOUSE_COLUMN : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		 SIGNAL MOUSE_CLICK : IN STD_LOGIC;
		 SIGNAL FEEDBACK_BULLET :IN STD_LOGIC;
		 SIGNAl CLOCK 			:IN STD_LOGIC;
		 SIGNAL BULLET_X_POSITION : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		 SIGNAL ENABLE_OUT : OUT STD_LOGIC );
END BULLET_FUNCTION;


ARCHITECTURE BEHAVIOUR OF BULLET_FUNCTION IS

SIGNAL PREVIOUS_STATE : STD_LOGIC := '0'; -- 1 INDICATES one mouse click has been registered

BEGIN

-- Bullet_X_Position <= (('0' & MOUSE_X_POSITION)- conv_STD_LOGIC_VECTOR(8,11)) when (Enable = '0') else Bullet_X_position;

PROCESS(MOUSE_CLICK, FEEDBACK_BULLET)
BEGIN

IF(MOUSE_CLICK = '1') THEN

	ENABLE_OUT <= '1';


--keep setting the bullet position until x_position is set
-- to 0 by the mouse click
ELSE 

		IF(FEEDBACK_BULLET = '1') THEN
			ENABLE_OUT <= '0';
		ELSE
			ENABLE_OUT <= '1';
		END IF;
 
-- THIS resets the enable to 0 and so now the player waits for fire signal
END IF;

END PROCESS;


END BEHAVIOUR;