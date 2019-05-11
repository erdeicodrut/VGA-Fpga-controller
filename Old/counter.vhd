library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter is
	generic	(nr_bits: integer := 4);
	port(clock: in std_logic;		  
	reset: in std_logic;
	Q: inout std_logic_vector (nr_bits - 1 downto 0));
end counter;  	

architecture ARH of counter is
begin			   		
COUNT: process(clock, reset)
begin  
	if reset = '1' then
		Q <= (others => '0');
	elsif clock'event and clock = '1' then
		Q <= Q + '1';	  
	end if;	    
end process COUNT;			 
end ARH;
		