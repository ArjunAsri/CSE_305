-- Quartus II VHDL Template
-- Four-State Mealy State Machine

-- A Mealy machine has outputs that depend on both the state and
-- the inputs.	When the inputs change, the outputs are updated
-- immediately, without waiting for a clock edge.  The outputs
-- can be written more than once per state or per clock cycle.

library ieee;
use ieee.std_logic_1164.all;

entity FSM is

	port
	(
		SIGNAL BUTTON_1, BUTTON_2, BUTTON_3, RIGHT_CLICK, LEFT_CLICK, SW0, SW1, SCORE_REACHED		: IN STD_logic;
		VERT_SYNC 		: IN STD_LOGIC;
		clk,INPUT,RESTART		 : IN STD_LOGIC;
		Q1_IN,Q10_IN          : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		FONT_SIZE				: OUT STD_LOGIC_VECTOR (1 DOWNTO 0); 
		ENABLE_START_TEXT, ENABLE_LEVEL_1_TEXT, ENABLE_LEVEL_2_TEXT, ENABLE_LEVEL_0_TEXT, ENABLE_TIMER, ENABLE_WON_TEXT : OUT STD_LOGIC;
		ENABLE_ENEMY_TANK_1, ENABLE_ENEMY_TANK_2, ENABLE_ENEMY_TANK_3, ENABLE_BULLET : OUT STD_LOGIC;
		ENABLE_BULLET_FUNCTION, ENABLE_BULLET_COLLISION, ENABLE_CONSTANT_OUT,ENABLE_PLAYER_TANK  : OUT STD_LOGIC;
		RESET : OUT STD_LOGIC;
		PAUSE : OUT STD_LOGIC;
		ENABLE_LEVEL_3_TEXT : OUT STD_LOGIC;
		output	 : out	std_logic_vector(3 downto 0);
		TANK_REACHED_IN : IN STD_LOGIC;
		ENABLE_PAUSED_OUT : OUT STD_LOGIC
	);


end entity FSM;

architecture rtl of FSM is

	-- Build an enumerated type for the state machine
	type state_type is (RESET_STATE, START, LEVEL_0, LEVEL_1, LEVEL_2,LEVEL_3, INTERMEDIATE_1, INTERMEDIATE_2, WON_STATE);

	-- Register to hold the current state
	signal state : state_type := RESET_STATE; 

begin

	process (clk, RESTART)
	begin

		if (BUTTON_1 = '1') then
			state <= RESET_STATE;

		elsif (rising_edge(clk)) then

			-- Determine the next state synchronously, based on
			-- the current state and the input
			case state is
				when RESET_STATE=>
					 state <= START;
					 
				--PB_1 = 1
				when START=>
						if (LEFT_CLICK = '1') then
								state <= LEVEL_0;
						elsif (RIGHT_CLICK = '1') then
								state <= LEVEL_1;
						ELSE
								state <= START;
						end if;
				when LEVEL_0=>
					if (SCORE_REACHED = '1')then
						state <= RESET_STATE;
					else
					   state <= LEVEL_0;
					end if;  
				when LEVEL_1=>
					if (SCORE_REACHED = '1') then
						state <= INTERMEDIATE_1;
					ELSIF (((Q1_IN = O"60") AND (Q10_IN = O"60")) OR (TANK_REACHED_IN = '1')) THEN
						state <= RESET_STATE;
					ELSE
						state <= LEVEL_1;
					end if;
				when LEVEL_2=>
				if (SCORE_REACHED = '1') then
						state <= INTERMEDIATE_2;
					ELSIF (((Q1_IN = O"60") AND (Q10_IN = O"60")) OR (TANK_REACHED_IN = '1')) THEN
						state <= RESET_STATE;
					ELSE
						state <= LEVEL_2;
					end if;
				when LEVEL_3=>
				if (SCORE_REACHED = '1') then
						state <= WON_STATE;
					ELSIF (((Q1_IN = O"60") AND (Q10_IN = O"60")) OR (TANK_REACHED_IN = '1')) THEN
						state <= RESET_STATE;
					ELSE
						state <= LEVEL_3;
					end if;
				when INTERMEDIATE_1=>
					state <=  LEVEL_2;
					
				when INTERMEDIATE_2=>
					state <=  LEVEL_3;
					
--				when INTERMEDIATE_3=>
--					if input = '1' then
--						state <= START;
--					else
--						state <= INTERMEDIATE_3;
--					end if;
				when WON_STATE=>
					if right_CLICK = '1' then
						state <= RESET_STATE;
					else
						state <= WON_STATE;
					end if;
					WHEN OTHERS =>
						STATE <= reset_state;
			end case;

		end if;
	end process;

	-- Determine the output based only on the current state
	-- and the input (do not wait for a clock edge).
	process (state, input,SW0,CLK)
	begin
			RESET <= '0';
			case state is
				when RESET_STATE=>
						RESET <= '1';
					--	Font_size <= "11";
						--ENABLE_ENEMY_TANK_1 <= '0';
						--ENABLE_BULLET       <= '0';
						--ENABLE_PLAYER_TANK  <= '0';
						--ENABLE_CONSTANT_OUT <= '0';
						--ENABLE_START_TEXT <= '1';
						--ENABLE_LEVEL_0_TEXT <= '0';
						--ENABLE_LEVEL_1_TEXT <= '0';
				-----------------------------------------------------------	
				when START=>
						RESET <= '0';
						ENABLE_TIMER <= '0';
					--	Font_size <= "11";
						ENABLE_ENEMY_TANK_1 <= '0';
						ENABLE_ENEMY_TANK_2 <= '0';
						ENABLE_ENEMY_TANK_3 <= '0';
						ENABLE_BULLET       <= '0';
						ENABLE_PLAYER_TANK  <= '0';
						ENABLE_CONSTANT_OUT <= '0';
						ENABLE_START_TEXT <= '1';
						ENABLE_LEVEL_0_TEXT <= '0';
						ENABLE_LEVEL_1_TEXT <= '0';
						ENABLE_LEVEL_2_TEXT <= '0';
						ENABLE_LEVEL_3_TEXT <= '0';
						ENABLE_WON_TEXT <= '0';
						pause <= '0';
					if (sw0 = '1') then
						pause <= '1';
					end if;
				------------------------------------------------------------
				when LEVEL_0=>
						RESET <= '0';
						ENABLE_TIMER <= '0';
						ENABLE_ENEMY_TANK_1 <= '1';
						ENABLE_ENEMY_TANK_2 <= '0';
						ENABLE_ENEMY_TANK_3 <= '0';
						ENABLE_BULLET       <= '1';
						ENABLE_PLAYER_TANK  <= '1';
						ENABLE_CONSTANT_OUT <= '1';
						ENABLE_START_TEXT <= '0';
						ENABLE_LEVEL_0_TEXT <= '1';
						ENABLE_LEVEL_1_TEXT <= '0';
						ENABLE_LEVEL_2_TEXT <= '0';
						ENABLE_LEVEL_3_TEXT <= '0';
						ENABLE_WON_TEXT <= '0';
						pause <= '0';
					if (sw0 = '1') then
						pause <= '1';
						ENABLE_PAUSED_OUT <= '1';
					--	Font_size <= "11";
					else	
						pause <= '0';
						ENABLE_PAUSED_OUT <= '0';
					end if;
				-------------------------------------------------------------
				when LEVEL_1=>
						RESET <= '0';
						ENABLE_TIMER <= '1';
						ENABLE_ENEMY_TANK_1 <= '1';
						ENABLE_ENEMY_TANK_2 <= '0';
						ENABLE_ENEMY_TANK_3 <= '0';
						ENABLE_BULLET       <= '1';
						ENABLE_PLAYER_TANK  <= '1';
						ENABLE_CONSTANT_OUT <= '1';
						ENABLE_START_TEXT <= '0';
						ENABLE_LEVEL_0_TEXT <= '1';
						ENABLE_LEVEL_1_TEXT <= '1';
						ENABLE_LEVEL_2_TEXT <= '0';
						ENABLE_LEVEL_3_TEXT <= '0';
						ENABLE_WON_TEXT <= '0';
						pause <= '0';
					if (sw0 = '1') then
						pause <= '1';
						ENABLE_PAUSED_OUT <= '1';
					--	Font_size <= "11";
					else	
						pause <= '0';
						ENABLE_PAUSED_OUT <= '0';
					end if;
				-------------------------------------------------------------
				when INTERMEDIATE_1=>
						RESET <= '1';
				-------------------------------------------------------------
				when LEVEL_2=>
						RESET <= '0';
						ENABLE_TIMER <= '1';
						ENABLE_ENEMY_TANK_1 <= '1';
						ENABLE_ENEMY_TANK_2 <= '1';
						ENABLE_ENEMY_TANK_3 <= '0';
						ENABLE_BULLET       <= '1';
						ENABLE_PLAYER_TANK  <= '1';
						ENABLE_CONSTANT_OUT <= '1';
						ENABLE_START_TEXT <= '0';
						ENABLE_LEVEL_0_TEXT <= '1';
						ENABLE_LEVEL_1_TEXT <= '0';
						ENABLE_LEVEL_2_TEXT <= '1';
						ENABLE_LEVEL_3_TEXT <= '0';
						ENABLE_WON_TEXT <= '0';
						pause <= '0';
					if (sw0 = '1') then
						pause <= '1';
						ENABLE_PAUSED_OUT <= '1';
					--	Font_size <= "11";
					else	
						pause <= '0';
						ENABLE_PAUSED_OUT <= '0';
					end if;
				-------------------------------------------------------------
				when INTERMEDIATE_2=>
						RESET <= '1';
				--------------------------------------------------------------
				when LEVEL_3=>
						RESET <= '0';
						ENABLE_TIMER <= '1';
						ENABLE_ENEMY_TANK_1 <= '1';
						ENABLE_ENEMY_TANK_2 <= '1';
						ENABLE_ENEMY_TANK_3 <= '1';
						ENABLE_BULLET       <= '1';
						ENABLE_PLAYER_TANK  <= '1';
						ENABLE_CONSTANT_OUT <= '1';
						ENABLE_START_TEXT <= '0';
						ENABLE_LEVEL_0_TEXT <= '1';
						ENABLE_LEVEL_1_TEXT <= '0';
						ENABLE_LEVEL_2_TEXT <= '0';
						ENABLE_LEVEL_3_TEXT <= '1';
						ENABLE_WON_TEXT <= '0';
						pause <= '0';
					if (sw0 = '1') then
						pause <= '1';
						ENABLE_PAUSED_OUT <= '1';
					--	Font_size <= "11";
					else	
						pause <= '0';
						ENABLE_PAUSED_OUT <= '0';
					end if;
				---------------------------------------------------------------

				--------------------------------------------------------------
				when WON_STATE=>
					RESET <= '0';
						ENABLE_TIMER <= '0';
						ENABLE_ENEMY_TANK_1 <= '0';
						ENABLE_ENEMY_TANK_2 <= '0';
						ENABLE_ENEMY_TANK_3 <= '0';
						ENABLE_BULLET       <= '0';
						ENABLE_PLAYER_TANK  <= '0';
						ENABLE_CONSTANT_OUT <= '0';
						ENABLE_START_TEXT <= '0';
						ENABLE_LEVEL_0_TEXT <= '0';
						ENABLE_LEVEL_1_TEXT <= '0';
						ENABLE_LEVEL_2_TEXT <= '0';
						ENABLE_LEVEL_3_TEXT <= '0';
						ENABLE_WON_TEXT <= '1';
						pause <= '0';
					if (sw0 = '1') then
						pause <= '1';
						ENABLE_PAUSED_OUT <= '1';
					--	Font_size <= "11";
					else	
						pause <= '0';
						ENABLE_PAUSED_OUT <= '0';
				
					end if;

				---------------------------------------------------------------
			end case;
	end process;
end rtl;