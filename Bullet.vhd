			-- Bouncing Bullet Video 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
LIBRARY lpm;
USE lpm.lpm_components.ALL;

ENTITY Bullet IS
Generic(ADDR_WIDTH: integer := 12; DATA_WIDTH: integer := 1);

   PORT(SIGNAL PB1, Clock: IN std_logic;
	     SIGNAL SW0                     : IN std_logic;
		  SIGNAL Enable, MASTER_ENABLE                  : IN std_logic;
		  SIGNAL ENABLE_DISPLAY						: IN STD_LOGIC;
		  SIGNAL MOUSE_X_POSITION 			:IN  STD_LOGIC_VECTOR (9 DOWNTO 0);
	     SIGNAL pixel_row_Bullet        : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		  SIGNAL pixel_column_Bullet     : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		  SIGNAL vert_sync_int           : IN std_logic; 
		  SIGNAL MOUSE_CLICK 				   : IN STD_LOGIC; 
		  SIGNAL FEEDBACK						: OUT STD_LOGIC;
		  SIGNAL Bullet_X_Position, Bullet_Y_Position : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
        SIGNAL Red,Green,Blue 			: OUT STD_LOGIC_VECTOR(3 downto 0));		
END Bullet;

			-- Bouncing Bullet Video 

architecture behavior of Bullet is

			-- Video Display Signals   
SIGNAL reset, Bullet_on, Direction			: std_logic;
--SIGNAL vert_sync_int, horiz_sync_int : std_logic;
SIGNAL Size 								: std_logic_vector(10 DOWNTO 0);  
SIGNAL Bullet_Y_motion 						: std_logic_vector(10 DOWNTO 0);
SIGNAL Bullet_Y_pos, Bullet_X_pos  	: std_logic_vector(10 DOWNTO 0);
SIGNAL t_FEEDBACK						: STD_LOGIC := '0';

BEGIN           

Size <= CONV_STD_LOGIC_VECTOR(2,11);
--Bullet_X_pos <= (('0' & MOUSE_X_POSITION)- conv_STD_LOGIC_VECTOR(8,11)) when (Enable = '0') else Bullet_X_pos;
--Bullet_X_pos <= CONV_STD_LOGIC_VECTOR(475,11);

--MOUSE_POSITION: PROCESS (vert_sync_int)
--begin
--IF ((Enable = '1'))THEN
--	IF(indicate_mouse_boolean = 1) then
--	BULLet_X_pos <= (('0' & MOUSE_X_POSITION)- conv_STD_LOGIC_VECTOR(8,11));
--	indicate_mouse_boolean := 0;
--	ELSE
--	Bullet_X_pos <= Bullet_X_pos;
--	END IF;
--ELSE
--indicate_mouse_boolean := 0;
--	Bullet_X_pos <= Bullet_X_pos;
--
--END IF;
--END PROCESS MOUSE_POSITION;
		-- need internal copy of vert_sync to read

		-- Colors for pixel data on video signal
--Red   <=  '1' when (Bullet_on = '1') else '0';		
Red(0)   <=  '1' when (Bullet_on = '1') else '0';
Red(1)   <=  '1' when (Bullet_on = '1') else '0';
Red(2)   <=  '1' when (Bullet_on = '1') else '0';
Red(3)   <=  '1' when (Bullet_on = '1') else '0';
		-- Turn off Green and Blue when displaying Bullet
--Green <=  '0' when (Bullet_on = '1') else '0';
Green(0) <=  '1' when (Bullet_on = '1') else '0';
Green(1) <=  '1' when (Bullet_on = '1') else '0';
Green(2) <=  '1' when (Bullet_on = '1') else '0';
Green(3) <=  '1' when (Bullet_on = '1') else '0';

--Blue  <=  '0' when (Bullet_on = '1') else '0';
Blue(0)  <=  '0' when (Bullet_on = '1') else '0';
Blue(1)  <=  '1' when (Bullet_on = '1') else '0';
Blue(2)  <=  '1' when (Bullet_on = '1') else '0';
Blue(3)  <=  '1' when (Bullet_on = '1') else '0';

--END PROCESS MOUSE_INPUTS;

RGB_Display: Process (Bullet_X_pos, Bullet_Y_pos, pixel_column_Bullet, pixel_row_Bullet, Size, Enable,ENABLE_DISPLAY)
begin
			-- Set Bullet_on ='1' to display Bullet
 IF ('0' & Bullet_X_pos <= pixel_column_Bullet + Size+(conV_STD_LOGIC_VECTOR(1,11))) AND
 			-- compare positive numbers only
 	(Bullet_X_pos + Size +(conV_STD_LOGIC_VECTOR(1,11)) >= '0' & pixel_column_Bullet) AND
 	('0' & Bullet_Y_pos <= pixel_row_Bullet + Size) And
 	(Bullet_Y_pos + Size >= '0' & pixel_row_Bullet ) AND 
	
	
	('0' & Bullet_X_pos <= pixel_column_Bullet + Size) AND
 			-- compare positive numbers only
 	(Bullet_X_pos + Size >= '0' & pixel_column_Bullet) AND
 	('0' & Bullet_Y_pos <= pixel_row_Bullet + Size+(conV_STD_LOGIC_VECTOR(1,11))) And
 	(Bullet_Y_pos +(conV_STD_LOGIC_VECTOR(1,11))+ Size >= '0' & pixel_row_Bullet ) AND 
	
	(Enable = '1') AND (Enable_dISPLAY = '1') AND (MASTER_ENABLE = '1') 
	
--	('0' & Bullet_X_pos <= pixel_column_Bullet + "00000000001") AND (Bullet_X_pos + "00000000001" >= '0' & pixel_column_Bullet) AND
--		('0' & Bullet_Y_pos <= pixel_row_Bullet + "00000000001") AND (Bullet_Y_pos + "00000000001" >= '0' & pixel_row_Bullet )
	
	
	THEN
--IF (Pixel_row_Bullet > 159 AND Pixel_row_Bullet < 320 AND Pixel_column_Bullet < 440 AND Pixel_column_Bullet > (CONV_STD_LOGIC_VECTOR(199,11))) THEN
--IF ((((CONV_STD_LOGIC_VECTOR(480,11)*Pixel_row_Bullet - (Pixel_row_Bullet*Pixel_row_Bullet)) + (CONV_STD_LOGIC_VECTOR(480,11)*Pixel_column_Bullet - (Pixel_column_Bullet*Pixel_column_Bullet))) < "100111000011111100") AND (Enable = '1') AND (Enable_dISPLAY = '1') AND (MASTER_ENABLE = '1'))THEN
 		Bullet_on <= '1';
 	ELSE
 		Bullet_on <= '0';
END IF;
--END IF;
END process RGB_Display;

Move_Bullet: process(vert_sync_int, Enable,ENABLE_DISPLAY)

BEGIN
			-- Move Bullet once every vertical sync
	--WAIT UNTIL vert_sync_int'event and vert_sync_int = '1';
IF (SW0 = '0') THEN
	IF (vert_sync_int'event and vert_sync_int = '1' AND MASTER_ENABLE = '1') then
			IF (Enable = '1' ) THEN
			
			-- Bounce off top or bottom of screen
			--IF ('0' & Bullet_Y_pos) >=  CONV_STD_LOGIC_VECTOR(480,11) - SIZE THEN
				-- Bullet_Y_motion <= - CONV_STD_LOGIC_VECTOR(2,11);
					IF (Bullet_Y_pos <= Size or (Enable_dISPLAY = '0')) THEN
						t_FEEDBACK <= '1';
						Bullet_Y_pos    <= CONV_STD_LOGIC_VECTOR(462,11);
						Bullet_X_pos    <= (('0' & MOUSE_X_POSITION)- conv_STD_LOGIC_VECTOR(8,11));
			--ELSIF (ENABLE = '1' AND (BULlet_X_pos = CONV_STD_LOGIC_VECTOR(462,11))) THEN
				--bullet_X_Pos <= (('0' & MOUSE_X_POSITION)- conv_STD_LOGIC_VECTOR(8,11));
					ELSE
						t_FEEDBACK <= '0';
						Bullet_Y_motion <= - CONV_STD_LOGIC_VECTOR(10,11);
			-- Compute next Bullet Y position
						Bullet_Y_pos <= Bullet_Y_pos + Bullet_Y_motion;
					END IF;
			ELSE
						Bullet_X_pos <= (('0' & MOUSE_X_POSITION)- conv_STD_LOGIC_VECTOR(8,11));
				END IF;
END IF;
ELSE
	if (Bullet_Y_Pos = CONV_STD_LOGIC_VECTOR(462,11)) then
	Bullet_X_pos <= ('0' & MOUSE_X_POSITION)- conv_STD_LOGIC_VECTOR(12,11);
	end if;
	Bullet_Y_Pos <= Bullet_Y_Pos;
end if;
END process Move_Bullet;
 FEEDBACK <= t_FEEDBACK;
BUllet_X_Position <= Bullet_X_pos;
Bullet_Y_Position <= bullet_Y_pos;
END behavior;