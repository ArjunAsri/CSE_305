library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY ConstantOut IS
	PORT(
			pixel_row_char, pixel_column_char	: IN	STD_LOGIC_VECTOR(10 DOWNTO 0);
			Score_Update, Score_Update_2, Score_Update_3 : IN STD_LOGIC;
			vert_sync    : IN STD_LOGIC;
			clock_1hz_IN : IN	STD_LOGIC;
			SW0          : IN STD_LOGIC;
			BULLET_X_POSITION,BULLET_Y_POSITION : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			SCORE_REACHED : OUT STD_LOGIC;
			ENABLE_START_TEXT, ENABLE_LEVEL_0_TEXT, ENABLE_LEVEL_1_TEXT, ENABLE_LEVEL_2_TEXT,ENABLE_LEVEL_3_TEXT, ENABLE_TIMER, ENABLE_WON:  IN STD_LOGIC;
		--	SELECT_CONSTANT_IN : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		--	ENABLE_CONSTANT_IN : IN STD_LOGIC;
			RESET : IN STD_LOGIC;
			Q	: OUT	STD_LOGIC_VECTOR(5 DOWNTO 0);
			Enable : OUT STD_LOGIC;
			Q1,Q10 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
			r,g,b : OUT STD_LOGIC_VECTOR(3 downto 0);
			ENABLE_PAUSED : IN STD_LOGIC);
END ConstantOut;

architecture Behaviour of CONSTANTOUT is
signal Enable_temp : STD_LOGIC := '0';
signal Current_Score : Integer range 0 to 100 := 0;
signal Q1_t : STD_LOGIC_VECTOR(5 DOWNTO 0) := O"60"; -- 0
signal Q10_t : STD_LOGIC_VECTOR(5 DOWNTO 0) := O"71"; -- 6

begin
--Enable <= '1' when ( pixel_row_char <= 14 ) and ( pixel_column_char <= 14 )	else '0';
r(0) <= '0' when (Enable_temp = '1') else '0';
r(1) <= '0' when (Enable_temp = '1') else '0';
r(2) <= '0' when (Enable_temp = '1') else '0';
r(3) <= '0' when (Enable_temp = '1') else '0';

g(0) <= '1' when (Enable_temp = '1') else '0';
g(1) <= '1' when (Enable_temp = '1') else '0';
g(2) <= '1' when (Enable_temp = '1') else '0';
g(3) <= '1' when (Enable_temp = '1') else '0';

b(0) <= '1' when (Enable_temp = '1') else '0';
b(1) <= '1' when (Enable_temp = '1') else '0';
b(2) <= '1' when (Enable_temp = '1') else '0';
b(3) <= '1' when (Enable_temp = '1') else '0';

--Q1_t <= O"71" when ((Q1_t = O"60") and ((Q10_t = O"65") or (Q10_t = O"64") or (Q10_t = O"63") or(Q10_t = O"62") or (Q10_t = O"61"))) else Q1_t;


--Process (vert_sync) 
--Begin
--	if (rising_edge(vert_sync) and Score_update = '1') then
--		Current_Score <= Current_Score + 1;
--		--output_to_fsm <= '1';		
--	else 
--		Current_Score <= Current_Score;
--	end if;
--end process;
Process (vert_sync, Score_Update) 
Begin
IF RESET = '1' THEN	
	SCORE_REACHED <= '0';
	CURRENT_SCORE <= 0;
	
	ELSIF ((rising_edge(Score_Update))) then
		Current_Score <= Current_Score + 1;
			if (Current_Score = 10) then
				SCORE_REACHED <= '1';
				Current_Score <= 0;
			else 
			   SCORE_REACHED <= '0';
			
			end if;
	end if;
end process;

--------------------------------------------------------------------------------------
Process (pixel_column_char,pixel_row_char)
Begin
--IF (SELECT_CONSTANT_IN = "001") THEN 	
	--if (( pixel_row_char >= (bulLET_y_POSITION)- conv_std_logic_vector(8,11)) and (pixel_row_char <= (bulLET_y_POSITION)+conv_std_logic_vector(8,11)) and ((bullet_X_POSITION)-conv_std_logic_vector(8,11) <= pixel_column_char) and (pixel_column_char <= (bullet_X_POSITION )+conv_std_logic_vector(8,11))AND (ENABLE_LEVEL_0_TEXT = '1')) then
		 -- Q <= O"34"; -- S
	     --Enable_temp <= '1';
	if (( pixel_row_char <= 15 ) and ( pixel_column_char <= 15 ) AND (ENABLE_LEVEL_0_TEXT = '1')) then
		  Q <= O"23"; -- S
	     Enable_temp <= '1';
   elsif (( pixel_row_char <= 15) and ( 16 <= pixel_column_char) and (pixel_column_char <= 31 ) AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"03"; -- C
		  Enable_temp <= '1';
   elsif (( pixel_row_char <= 15) and ( 32 <= pixel_column_char) and (pixel_column_char <= 47 )AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"17"; -- O
		  Enable_temp <= '1';
   elsif (( pixel_row_char <= 15) and ( 48 <= pixel_column_char) and (pixel_column_char <= 63 )AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"22"; -- R
		  Enable_temp <= '1';
   elsif (( pixel_row_char <= 15) and ( 64 <= pixel_column_char) and (pixel_column_char <= 79 )AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 80 <= pixel_column_char) and (pixel_column_char <= 95 )AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"77"; -- Colon
		  Enable_temp <= '1';
   elsif (( pixel_row_char <= 15) and ( 96 <= pixel_column_char) and (pixel_column_char <= 111 ) and (Current_Score /= 10)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"60"; -- 0
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 10)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"60"; -- 0
		  Enable_temp <= '1';
		  
   elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 0)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"60"; -- 0
		  Enable_temp <= '1';
		
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 1)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"61"; -- 1
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 2)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"62"; -- 2
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 3)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"63"; -- 3
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 4)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"64"; -- 4
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 5)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"65"; -- 5
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 6)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"66"; -- 6
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 7)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"67"; -- 7
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 8)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"70"; -- 8
		  Enable_temp <= '1';
		  
	elsif (( pixel_row_char <= 15) and ( 112 <= pixel_column_char) and (pixel_column_char <= 127 ) and (Current_Score = 9)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"71"; -- 9
		  Enable_temp <= '1';
		 
	elsif (( pixel_row_char <= 15) and ( 96 <= pixel_column_char) and (pixel_column_char <= 111 ) and (Current_Score = 10)AND(ENABLE_LEVEL_0_TEXT = '1')) then
	     Q <= O"61"; -- 1 at tens place
		  Enable_temp <= '1';
		
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and ( pixel_column_char <= 15 )AND(ENABLE_LEVEL_0_TEXT = '1') and (ENABLE_TIMER = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and ( 16 <= pixel_column_char) and (pixel_column_char <= 31 )AND(ENABLE_LEVEL_0_TEXT = '1') and (ENABLE_TIMER = '1')) then
	     Q <= O"11"; -- I
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (32 <= pixel_column_char) and (pixel_column_char <= 47 )AND(ENABLE_LEVEL_0_TEXT = '1') and (ENABLE_TIMER = '1')) then
	     Q <= O"15"; -- M
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (48 <= pixel_column_char) and (pixel_column_char <= 63 )AND(ENABLE_LEVEL_0_TEXT = '1') and (ENABLE_TIMER = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (64 <= pixel_column_char) and (pixel_column_char <= 79 )AND(ENABLE_LEVEL_0_TEXT = '1') and (ENABLE_TIMER = '1')) then
	     Q <= O"77"; -- Colon
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (80 <= pixel_column_char) and (pixel_column_char <= 95)AND(ENABLE_LEVEL_0_TEXT = '1') and (ENABLE_TIMER = '1')) then
        Q <= Q10_t;
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (96 <= pixel_column_char) and (pixel_column_char <= 111 )AND(ENABLE_LEVEL_0_TEXT = '1') and (ENABLE_TIMER = '1'))then
		  Q <= Q1_t;
		  Enable_temp <= '1';
	-------------------------------------------------------MENU SCREEN CHARACTERS----------------------------------------------------------
	--ELSIF (SELECT_CONSTANT_IN = "000") THEN 
--	ELSE
	--------------------------LEFT CLICK-------------------------------------
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (256 <= pixel_column_char) and (pixel_column_char <= 271 ) AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (272 <= pixel_column_char) and (pixel_column_char <= 287 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (288 <= pixel_column_char) and (pixel_column_char <= 303 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"06"; -- F
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (336 <= pixel_column_char) and (pixel_column_char <= 351 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"03"; -- C
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"11"; -- I
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (384 <= pixel_column_char) and (pixel_column_char <= 399 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"03"; -- C
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 159) and (pixel_row_char <= 174) and (400 <= pixel_column_char) and (pixel_column_char <= 415 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"13"; -- K
		  Enable_temp <= '1';
	------------------RIGHT CLICK----------------------
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (256 <= pixel_column_char) and (pixel_column_char <= 271 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"22"; -- R
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (272 <= pixel_column_char) and (pixel_column_char <= 287 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"11"; -- I
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (288 <= pixel_column_char) and (pixel_column_char <= 303 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"07"; -- G
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"10"; -- H
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (320 <= pixel_column_char) and (pixel_column_char <= 335 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"03"; -- C
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (384 <= pixel_column_char) and (pixel_column_char <= 399 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"11"; -- I
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (400 <= pixel_column_char) and (pixel_column_char <= 415 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"03"; -- C
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (416 <= pixel_column_char) and (pixel_column_char <= 431 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"13"; -- K
		  Enable_temp <= '1';
	
	----------------- TANK HUNTER -------------------
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (256 <= pixel_column_char) and (pixel_column_char <= 271 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (272 <= pixel_column_char) and (pixel_column_char <= 287 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"01"; -- A
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (288 <= pixel_column_char) and (pixel_column_char <= 303 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"16"; -- N
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"13"; -- K
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and  (336 <= pixel_column_char) and (pixel_column_char <= 351 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"10"; -- H
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"25"; -- U
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"16"; -- N
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (384 <= pixel_column_char) and (pixel_column_char <= 399 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (400 <= pixel_column_char) and (pixel_column_char <= 415 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
   elsif (( pixel_row_char >= 15) and (pixel_row_char <= 30) and (416 <= pixel_column_char) and (pixel_column_char <= 431 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"22"; -- R
		  Enable_temp <= '1';
	
	----------------- PRACTISE --------------------------
	elsif (( pixel_row_char >= 175) and (pixel_row_char <= 190) and (272 <= pixel_column_char) and (pixel_column_char <= 287 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"20"; -- P
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 175) and (pixel_row_char <= 190) and (288 <= pixel_column_char) and (pixel_column_char <= 303 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"22"; -- R
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 175) and (pixel_row_char <= 190) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"01"; -- A
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 175) and (pixel_row_char <= 190) and (320 <= pixel_column_char) and (pixel_column_char <= 335 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"03"; -- C
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 175) and (pixel_row_char <= 190) and (336 <= pixel_column_char) and (pixel_column_char <= 351 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 175) and (pixel_row_char <= 190) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"11"; -- I
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 175) and (pixel_row_char <= 190) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"23"; -- S
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 175) and (pixel_row_char <= 190) and (384 <= pixel_column_char) and (pixel_column_char <= 399 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	------------FULL GAME--------------------------------
	elsif (( pixel_row_char >= 223) and (pixel_row_char <= 238) and (272 <= pixel_column_char) and (pixel_column_char <= 287 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"06"; -- F
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 223) and (pixel_row_char <= 238) and (288 <= pixel_column_char) and (pixel_column_char <= 303 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"25"; -- U
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 223) and (pixel_row_char <= 238) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 223) and (pixel_row_char <= 238) and (320 <= pixel_column_char) and (pixel_column_char <= 335 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 223) and (pixel_row_char <= 238) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"07"; -- G
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 223) and (pixel_row_char <= 238) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"01"; -- A
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 223) and (pixel_row_char <= 238) and (384 <= pixel_column_char) and (pixel_column_char <= 399 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"15"; -- M
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 223) and (pixel_row_char <= 238) and (400 <= pixel_column_char) and (pixel_column_char <= 415 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';

	------------SW0------------------------------------------
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (256 <= pixel_column_char) and (pixel_column_char <= 271 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"23"; -- S
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (272 <= pixel_column_char) and (pixel_column_char <= 287 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"27"; -- W
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (288 <= pixel_column_char) and (pixel_column_char <= 303 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"60"; -- 0
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"55"; -- Hyphen
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (320 <= pixel_column_char) and (pixel_column_char <= 335 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"20"; -- P
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (336 <= pixel_column_char) and (pixel_column_char <= 351 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"01"; -- A
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"25"; -- U
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"23"; -- S
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 318) and (pixel_row_char <= 333) and (384 <= pixel_column_char) and (pixel_column_char <= 399 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';

		  ------------SW1------------------------------------------
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (256 <= pixel_column_char) and (pixel_column_char <= 271 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"02"; -- B
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (272 <= pixel_column_char) and (pixel_column_char <= 287 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (288 <= pixel_column_char) and (pixel_column_char <= 303 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"61"; -- 1
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"55"; -- Hyphen
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (320 <= pixel_column_char) and (pixel_column_char <= 335 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"22"; -- R
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (336 <= pixel_column_char) and (pixel_column_char <= 351 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"23"; -- S
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (384 <= pixel_column_char) and (pixel_column_char <= 399 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"01"; -- A
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (400 <= pixel_column_char) and (pixel_column_char <= 415 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"22"; -- R
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 334) and (pixel_row_char <= 349) and (416 <= pixel_column_char) and (pixel_column_char <= 431 )AND (ENABLE_START_TEXT = '1')) then
	     Q <= O"24"; -- T
		  Enable_temp <= '1';
	--------------------------LEVEL 1 text-----------------------------------------
	elsif (( pixel_row_char <= 15) and ( 256 <= pixel_column_char) and (pixel_column_char <= 271 ) AND(ENABLE_LEVEL_1_TEXT = '1')) then
	     Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 272 <= pixel_column_char) and (pixel_column_char <= 287 ) AND(ENABLE_LEVEL_1_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 288 <= pixel_column_char) and (pixel_column_char <= 303 ) AND(ENABLE_LEVEL_1_TEXT = '1')) then
	     Q <= O"26"; -- V
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 304 <= pixel_column_char) and (pixel_column_char <= 319 ) AND(ENABLE_LEVEL_1_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 320 <= pixel_column_char) and (pixel_column_char <= 335 ) AND(ENABLE_LEVEL_1_TEXT = '1')) then
		  Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 336 <= pixel_column_char) and (pixel_column_char <= 351 ) AND(ENABLE_LEVEL_1_TEXT = '1')) then
	     Q <= O"55"; -- Hyphen
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 352 <= pixel_column_char) and (pixel_column_char <= 367 ) AND(ENABLE_LEVEL_1_TEXT = '1')) then
		  Q <= O"61"; -- 1
		  Enable_temp <= '1';
		----------------------------LEVEL 2 text---------------------------------------
	elsif (( pixel_row_char <= 15) and ( 256 <= pixel_column_char) and (pixel_column_char <= 271 ) AND(ENABLE_LEVEL_2_TEXT = '1')) then
	     Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 272 <= pixel_column_char) and (pixel_column_char <= 287 ) AND(ENABLE_LEVEL_2_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 288 <= pixel_column_char) and (pixel_column_char <= 303 ) AND(ENABLE_LEVEL_2_TEXT = '1')) then
	     Q <= O"26"; -- V
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 304 <= pixel_column_char) and (pixel_column_char <= 319 ) AND(ENABLE_LEVEL_2_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 320 <= pixel_column_char) and (pixel_column_char <= 335 ) AND(ENABLE_LEVEL_2_TEXT = '1')) then
		  Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 336 <= pixel_column_char) and (pixel_column_char <= 351 ) AND(ENABLE_LEVEL_2_TEXT = '1')) then
	     Q <= O"55"; -- Hyphen
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 352 <= pixel_column_char) and (pixel_column_char <= 367 ) AND(ENABLE_LEVEL_2_TEXT = '1')) then
		  Q <= O"62"; -- 2
		  Enable_temp <= '1';
				---------------------------LEVEL 3 text----------------------------------------
	elsif (( pixel_row_char <= 15) and ( 256 <= pixel_column_char) and (pixel_column_char <= 271 ) AND(ENABLE_LEVEL_3_TEXT = '1')) then
	     Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 272 <= pixel_column_char) and (pixel_column_char <= 287 ) AND(ENABLE_LEVEL_3_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 288 <= pixel_column_char) and (pixel_column_char <= 303 ) AND(ENABLE_LEVEL_3_TEXT = '1')) then
	     Q <= O"26"; -- V
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 304 <= pixel_column_char) and (pixel_column_char <= 319 ) AND(ENABLE_LEVEL_3_TEXT = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 320 <= pixel_column_char) and (pixel_column_char <= 335 ) AND(ENABLE_LEVEL_3_TEXT = '1')) then
		  Q <= O"14"; -- L
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 336 <= pixel_column_char) and (pixel_column_char <= 351 ) AND(ENABLE_LEVEL_3_TEXT = '1')) then
	     Q <= O"55"; -- Hyphen
		  Enable_temp <= '1';
	elsif (( pixel_row_char <= 15) and ( 352 <= pixel_column_char) and (pixel_column_char <= 367 ) AND(ENABLE_LEVEL_3_TEXT = '1')) then
		  Q <= O"63"; -- 3
		  Enable_temp <= '1';
				
         -----------------------------PAUSED----------------------------------------------
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_PAUSED = '1')) then
	     Q <= O"20"; -- P
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (320 <= pixel_column_char) and (pixel_column_char <= 335 )AND (ENABLE_PAUSED = '1')) then
	     Q <= O"01"; -- A
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (336 <= pixel_column_char) and (pixel_column_char <= 351 )AND (ENABLE_PAUSED = '1')) then
	     Q <= O"25"; -- U
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_PAUSED = '1')) then
	     Q <= O"23"; -- S
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_PAUSED = '1')) then
	     Q <= O"05"; -- E
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (384 <= pixel_column_char) and (pixel_column_char <= 400 )AND (ENABLE_PAUSED = '1')) then
	     Q <= O"04"; -- D
		  Enable_temp <= '1';
		  ------------------------------WIN STAGE TEXT-------------------------------------------
		 
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (272 <= pixel_column_char) and (pixel_column_char <= 287 )AND (ENABLE_WON = '1')) then
	     Q <= O"31"; -- Y
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (288 <= pixel_column_char) and (pixel_column_char <= 303 )AND (ENABLE_WON = '1')) then
	     Q <= O"17"; -- O
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (304 <= pixel_column_char) and (pixel_column_char <= 319 )AND (ENABLE_WON = '1')) then
	     Q <= O"25"; -- U
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (320 <= pixel_column_char) and (pixel_column_char <= 335 )AND (ENABLE_WON = '1')) then
	     Q <= O"40"; -- SPACE
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (336 <= pixel_column_char) and (pixel_column_char <= 351 )AND (ENABLE_WON = '1')) then
	     Q <= O"27"; -- W
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (352 <= pixel_column_char) and (pixel_column_char <= 367 )AND (ENABLE_WON = '1')) then
	     Q <= O"11"; -- I
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (368 <= pixel_column_char) and (pixel_column_char <= 383 )AND (ENABLE_WON = '1')) then
	     Q <= O"16"; -- N
		  Enable_temp <= '1';
	elsif (( pixel_row_char >= 207) and (pixel_row_char <= 222) and (384 <= pixel_column_char) and (pixel_column_char <= 399 )AND (ENABLE_WON = '1')) then
	     Q <= O"41"; -- N
		  Enable_temp <= '1';
	

	
	else
		  Enable_temp <= '0';


	end if;
--end if; -- FOR SELECT SIGNAL
end process;

process (clock_1hz_IN) 
begin
IF RESET = '1' THEN
Q1_t <= O"60";
Q10_t <= O"71";
elsif (SW0 = '0') then
	if (rising_edge(clock_1hz_IN)) then
		IF(ENABLE_TIMER = '1') THEN
			if ((Q1_t = O"60") and (Q10_t /= O"60")) then
				 Q10_t <= Q10_t - "000001";
				 Q1_t <= O"71";
		   elsif (Q10_t = O"60") and (Q1_t = O"60") then
			       Q1_t <= O"60";
					 Q10_t <= Q10_t;
			else
				 Q1_t <= Q1_t - "000001";	
			end if;
		ELSE
		Q1_t <= O"60";
		Q10_t <= O"71";
	END IF;
	end if;
else
Q1_t <= Q1_t;
Q10_t <= Q10_t;
END IF;
end process;
Enable <= Enable_Temp;
Q1 <= Q1_t;
Q10 <= Q10_t;

end behaviour;
