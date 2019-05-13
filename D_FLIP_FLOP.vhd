LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

ENTITY D_FLIP_FLOP IS 
PORT ( SIGNAL CLK, RESET, D : IN STD_LOGIC;
		 SIGNAL Q, Q_BAR : OUT STD_LOGIC );
END D_FLIP_FLOP;


ARCHITECTURE BEHAVIOUR OF D_FLIP_FLOP IS

-- SIGNAL t_BULLET_X_POSITION : STD_LOGIC_VECTOR (10 DOWNTO 0) := '0' & MOUSE_COLUMN;
SIGNAL COUNT_T :STD_LOGIC := '1';
BEGIN
 
PROCESS(clk) -- clock is needed to check the sensitivity list all the time. A variable count can be used to make the 
VARIABLE ENABLE_T : STD_LOGIC; -- SIGNAL IS ENABLED
																				-- block reappear
BEGIN

IF(rising_edge(clk))THEN
	IF( D = '0' AND RESET = '0') THEN
	ENABLE_T := ENABLE_T;
	ELSIF ( D = '1' AND RESET = '1' ) THEN
	ENABLE_T := NOT ENABLE_T;
	ELSIF ( D = '0' AND RESET = '1' ) THEN
	ENABLE_T := '0';
	ELSE
	ENABLE_T := '1';
	END IF;
END IF;
Q <= ENABLE_T;
Q_BAR <= NOT ENABLE_T;
END PROCESS;
END BEHAVIOUR;