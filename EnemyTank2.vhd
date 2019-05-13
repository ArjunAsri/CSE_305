			-- Bouncing EnemyTank2 Video 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
LIBRARY lpm;
USE lpm.lpm_components.ALL;

ENTITY EnemyTank2 IS
Generic(ADDR_WIDTH: integer := 12; DATA_WIDTH: integer := 1);

   PORT(SIGNAL PB1, PB2, Clock,Enable_Display 			: IN std_logic;
		  SIGNAL LFSR_IN						: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	     SIGNAL SW0, MASTER_ENABLE      : IN std_logic;
	     SIGNAL pixel_row_EnemyTank2     : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		  SIGNAL pixel_column_EnemyTank2  : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		  SIGNAL vert_sync_int           : IN std_logic; 
		  SIGNAL RESET_COLLISION2			: OUT STD_LOGIC;
		  SIGNAL TANK2_X_POS, TANK2_Y_POS	: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
		  SIGNAL ENABLE_COLLISION_DETECTION : OUT STD_LOGIC;
        SIGNAL Red,Green,Blue 			: OUT STD_LOGIC_VECTOR(3 downto 0));		
END EnemyTank2;

			-- Bouncing EnemyTank2 Video 

architecture behavior of EnemyTank2 is

			-- Video Display Signals   
SIGNAL reset, EnemyTank2_on, Direction			: std_logic;
SIGNAL ALLOW_DETECTION 								: STD_LOGIC := '1';
--SIGNAL vert_sync_int, horiz_sync_int : std_logic;
SIGNAL Size 								: std_logic_vector(10 DOWNTO 0);  
SIGNAL EnemyTank2_X_motion 						: std_logic_vector(10 DOWNTO 0);
SIGNAL EnemyTank2_Y_pos, EnemyTank2_X_pos	: std_logic_vector(10 DOWNTO 0);
SIGNAL Reapppear_Tank							:	STD_LOGIC;
shared variable y_position:integer := 40;
BEGIN           

Size <= CONV_STD_LOGIC_VECTOR(8,11);
--EnemyTank2_Y_pos <= CONV_STD_LOGIC_VECTOR(40,11);


		-- need internal copy of vert_sync to read

		-- Colors for pixel data on video signal
--Red   <=  '1' when (EnemyTank2_on = '1') else '0';		
Red(0)   <=  '1' when (EnemyTank2_on = '1') else '0';
Red(1)   <=  '1' when (EnemyTank2_on = '1') else '0';
Red(2)   <=  '1' when (EnemyTank2_on = '1') else '0';
Red(3)   <=  '1' when (EnemyTank2_on = '1') else '0';
		-- Turn off Green and Blue when displaying EnemyTank2
--Green <=  '0' when (EnemyTank2_on = '1') else '0';
Green(0) <=  '0' when (EnemyTank2_on = '1') else '0';
Green(1) <=  '0' when (EnemyTank2_on = '1') else '0';
Green(2) <=  '0' when (EnemyTank2_on = '1') else '0';
Green(3) <=  '0' when (EnemyTank2_on = '1') else '0';

--Blue  <=  '0' when (EnemyTank2_on = '1') else '0';
Blue(0)  <=  '0' when (EnemyTank2_on = '1') else '0';
Blue(1)  <=  '1' when (EnemyTank2_on = '1') else '0';
Blue(2)  <=  '0' when (EnemyTank2_on = '1') else '0';
Blue(3)  <=  '1' when (EnemyTank2_on = '1') else '0';

RGB_Display: Process (EnemyTank2_X_pos, EnemyTank2_Y_pos, pixel_column_EnemyTank2, pixel_row_EnemyTank2, Size,Enable_Display)
BEGIN
			-- Set EnemyTank2_on ='1' to display EnemyTank2
 IF ('0' & EnemyTank2_X_pos <= pixel_column_EnemyTank2 + Size) AND
 			-- compare positive numbers only
 	(EnemyTank2_X_pos + Size >= '0' & pixel_column_EnemyTank2) AND
 	('0' & EnemyTank2_Y_pos <= pixel_row_EnemyTank2 + Size) AND
 	(EnemyTank2_Y_pos + Size >= '0' & pixel_row_EnemyTank2 ) AND (Enable_Display = '1') AND (MASTER_ENABLE = '1') THEN
 		EnemyTank2_on <= '1';
		--ALLOW_DETECTION <= '1';
		--RESET_COLLISION <= '0';
 	ELSE
 		EnemyTank2_on    <= '0';
		--ALLOW_DETECTION <= '0';
		--RESET_COLLISION <= '1';
END IF;

END process RGB_Display;

Move_EnemyTank2: process(vert_sync_int)
variable count : STD_LOGIC := '1';
BEGIN
			
IF  (SW0 = '0') then --(PB1 = '0')and (count = '0') then -- added
	IF (vert_sync_int'event and vert_sync_int = '1' AND MASTER_ENABLE = '1') THEN
			IF(Enable_Display = '1') then
					REApppear_Tank <= '0';
					
				IF ('0' & EnemyTank2_X_pos) >=  CONV_STD_LOGIC_VECTOR(640,11) - Size THEN
					EnemyTank2_X_motion <= - CONV_STD_LOGIC_VECTOR(5,11);
					y_position := y_position + 8;
				ELSIF EnemyTank2_X_pos <= Size THEN
					EnemyTank2_X_motion <= CONV_STD_LOGIC_VECTOR(5,11);
					y_position := y_position + 8;
				END IF;
					EnemyTank2_X_pos <= EnemyTank2_X_pos + EnemyTank2_X_motion;
			ELSE
					REApppear_Tank <= '1';
					EnemyTank2_X_pos <=  ("00" & LFSR_IN & '0') + CONV_STD_LOGIC_VECTOR(120,11);
					y_position := 48;
			END IF;
		end if;
ELSIF (SW0 = '1') then 
      EnemyTank2_X_pos <= EnemyTank2_X_pos;
	
	   --EnemyTank2_X_pos <= CONV_STD_LOGIC_VECTOR(275,11);
	   --REApppear_Tank <= '1';
--ELSIF (ENABLE_Display = '1') THEN
		--REApppear_Tank <= '0';
END IF;-- added
END process Move_EnemyTank2;
RESET_COLLISION2 <= REApppear_Tank;
ENABLE_COLLISION_DETECTION <= ALLOW_DETECTION;
TANK2_X_POS <= EnemyTank2_X_pos;
TANK2_Y_POS <= EnemyTank2_Y_pos;
EnemyTank2_Y_pos <= conv_STD_LOGIC_VECTOR(y_position,11);
END behavior;