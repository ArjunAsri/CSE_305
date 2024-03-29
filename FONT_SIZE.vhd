library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY FONT_SIZE IS
	PORT(	PIXEL_ROW, PIXEL_COLUMN: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
			vert_sync_in : IN STD_LOGIC;
			ENABLE_BITS : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			SELECTED_PIXEL_ROW_BITS, SELECTED_PIXEL_COLUMN_BITS	: OUT	STD_LOGIC_VECTOR(2 DOWNTO 0));
END FONT_SIZE;

architecture Behavior of FONT_SIZE is
SIGNAL SIGNAL_PIXEL_ROW: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL SIGNAL_PIXEL_COLUMN : STD_LOGIC_VECTOR(2 DOWNTO 0);
begin
PROCESS(vert_sync_in,PIXEL_COLUMN,PIXEL_ROW,ENABLE_BITS) 
BEGIn

IF ( ENABLE_BITS = "00") THEN
	SIGNAL_PIXEL_COLUMN  <= PIXEL_COLUMN(3 DOWNTO 1);
	SIGNAL_PIXEL_ROW <= PIXEL_ROW(3 DOWNTO 1);
ELSIF (ENABLE_BITS = "01") THEN
	SIGNAL_PIXEL_COLUMN  <= PIXEL_COLUMN(3 DOWNTO 1);
	SIGNAL_PIXEL_ROW <= PIXEL_ROW(3 DOWNTO 1);
ELSIF (ENABLE_BITS = "10") THEN
	SIGNAL_PIXEL_COLUMN  <= PIXEL_COLUMN(4 DOWNTO 2);
	SIGNAL_PIXEL_ROW <= PIXEL_ROW(4 DOWNTO 2);	
ELSE
	SIGNAL_PIXEL_COLUMN  <= PIXEL_COLUMN(5 DOWNTO 3);
	SIGNAL_PIXEL_ROW<= PIXEL_ROW(5 DOWNTO 3);	
END IF;
END PROCESS;
SELECTED_PIXEL_COLUMN_BITS <= SIGNAL_PIXEL_COLUMN;
SELECTED_PIXEL_ROW_BITS <= SIGNAL_PIXEL_ROW;
end Behavior;