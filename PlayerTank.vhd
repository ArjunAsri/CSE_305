			-- Bouncing PlayerTank Video 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
LIBRARY lpm;
USE lpm.lpm_components.ALL;

ENTITY PlayerTank IS
Generic(ADDR_WIDTH: integer := 12; DATA_WIDTH: integer := 1);

   PORT(SIGNAL PB1, PB2, Clock, MASTER_ENABLE 			: IN std_logic;
	     SIGNAL pixel_row_PlayerTank    : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		  SIGNAL pixel_column_PlayerTank : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		  SIGNAL vert_sync_int           : IN std_logic;  
		  SIGNAL Mouse_Column_Position   : IN std_logic_vector(9 DOWNTO 0);

        SIGNAL Red,Green,Blue 			: OUT STD_LOGIC_VECTOR(3 downto 0));		
END PlayerTank;

			-- Bouncing PlayerTank Video 

architecture behavior of PlayerTank is

			-- Video Display Signals   
SIGNAL reset, PlayerTank_on, Direction			: std_logic;
--SIGNAL vert_sync_int, horiz_sync_int : std_logic;
SIGNAL Size 								: std_logic_vector(10 DOWNTO 0);  
SIGNAL PlayerTank_X_motion 						: std_logic_vector(10 DOWNTO 0);
SIGNAL PlayerTank_Y_pos, PlayerTank_X_pos	: std_logic_vector(10 DOWNTO 0);

BEGIN           

Size <= CONV_STD_LOGIC_VECTOR(8,11);
PlayerTank_Y_pos <= CONV_STD_LOGIC_VECTOR(472,11);

		-- need internal copy of vert_sync to read

		
		-- Colors for pixel data on video signal
--Red   <=  '1' when (PlayerTank_on = '1') else '0';		
Red(0)   <=  '1' when (PlayerTank_on = '1') else '0';
Red(1)   <=  '1' when (PlayerTank_on = '1') else '0';
Red(2)   <=  '1' when (PlayerTank_on = '1') else '0';
Red(3)   <=  '1' when (PlayerTank_on = '1') else '0';
		-- Turn off Green and Blue when displaying PlayerTank
--Green <=  '0' when (PlayerTank_on = '1') else '0';
Green(0) <=  '0' when (PlayerTank_on = '1') else '0';
Green(1) <=  '0' when (PlayerTank_on = '1') else '0';
Green(2) <=  '0' when (PlayerTank_on = '1') else '0';
Green(3) <=  '0' when (PlayerTank_on = '1') else '0';

--Blue  <=  '0' when (PlayerTank_on = '1') else '0';
Blue(0)  <=  '0' when (PlayerTank_on = '1') else '0';
Blue(1)  <=  '0' when (PlayerTank_on = '1') else '0';
Blue(2)  <=  '0' when (PlayerTank_on = '1') else '0';
Blue(3)  <=  '0' when (PlayerTank_on = '1') else '0';

RGB_Display: Process (PlayerTank_X_pos, PlayerTank_Y_pos, pixel_column_PlayerTank, pixel_row_PlayerTank, Size)
BEGIN
			-- Set PlayerTank_on ='1' to display PlayerTank
 IF ('0' & PlayerTank_X_pos <= pixel_column_PlayerTank + Size) AND
 			-- compare positive numbers only
 	(PlayerTank_X_pos + Size >= '0' & pixel_column_PlayerTank) AND
 	('0' & PlayerTank_Y_pos <= pixel_row_PlayerTank + Size) AND
 	(PlayerTank_Y_pos + Size >= '0' & pixel_row_PlayerTank ) AND (MASTER_ENABLE = '1')THEN
 		PlayerTank_on <= '1';
 	ELSE
 		PlayerTank_on <= '0';
END IF;
END process RGB_Display;


Move_PlayerTank: process(vert_sync_int)
BEGIN
			-- Move PlayerTank once every vertical sync
	--WAIT UNTIL vert_sync_int'event and vert_sync_int = '1';
	IF (vert_sync_int'event and vert_sync_int = '1' AND MASTER_ENABLE = '1') then
			-- Compute next PlayerTank X position
				if (PlayerTank_X_pos <= CONV_STD_LOGIC_VECTOR(0,11) + Size) then 
				PlayerTank_X_pos <= ('0' & Mouse_Column_Position) + size;
				elsif (PlayerTank_X_pos <= CONV_STD_LOGIC_VECTOR(640,11) - Size) then 
				PlayerTank_X_pos <= ('0' & Mouse_Column_Position) - size;
            else
				PlayerTank_X_pos <= ('0' & Mouse_Column_Position);
		    	end if;
	END IF;
END process Move_PlayerTank;

END behavior;