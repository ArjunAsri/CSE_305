library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY Clock_Divider IS
	PORT(	clock_50Mhz	: IN	STD_LOGIC;
			clock_out_25Mhz	: OUT	STD_LOGIC;
			clock_out_1hz     : OUT STD_LOGIC
		);
END Clock_Divider;

architecture Behavior of Clock_Divider is
    signal temp: STD_LOGIC := '0';
	 signal Counter: Integer range 0 to 25000000 := 0;
	 signal t_clock_out_1hz : STD_LOGIC := '0';
begin
   
Clock: process (clock_50Mhz)

begin
       if rising_edge(clock_50Mhz) then
		 temp <= NOT(temp);
           end if;
    end process Clock;
    
    clock_out_25Mhz <= temp;

One_Second_Clock: process(clock_50Mhz)	 

begin
 if rising_edge(clock_50Mhz) then  
	 Counter <= Counter + 1;
		if (Counter = 25000000) then
			 t_clock_out_1hz <= not t_clock_out_1hz;
			 Counter <= 0;
		end if;
 end if;
End process One_Second_Clock;

clock_out_1hz <= t_clock_out_1hz;

end Behavior;