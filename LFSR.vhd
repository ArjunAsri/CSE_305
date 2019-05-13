--This is an 8 bit LFSR used to generate pseudo random numbers. These random numbers are in the range 0 to 255. These values are used
--by enemy tanks to respawn at a random location
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity LFSR is
Port ( clock : in STD_LOGIC;
       reset : in STD_LOGIC;

       Q : out STD_LOGIC_VECTOR (7 downto 0));

end LFSR;
architecture Behavior of LFSR is

signal Qt: STD_LOGIC_VECTOR(7 downto 0) := "00000001";
begin

PROCESS(clock)
variable tmp : STD_LOGIC := '0';
BEGIN

IF rising_edge(clock) THEN
   IF (reset='1') THEN
     Qt <= "00000001"; 
     ELSE
      tmp := Qt(4) XOR Qt(3) XOR Qt(2) XOR Qt(0); -- the xnor gates have been put at the tabs 4,3,2 and 0
      Qt <= tmp & Qt(7 downto 1);
   END IF;

END IF;
END PROCESS;
Q <= Qt;

end Behavior;