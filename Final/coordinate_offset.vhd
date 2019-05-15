library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity offsetCounter is
	generic(
	numberRange: Integer
	);
	port(			   
	plus: in std_logic;	
	offset: inout integer := numberRange / 3
	);
end offsetCounter;

architecture offsetCounterArchitecture of offsetCounter is	 

begin
	process(plus, offset)
	begin	   	   	  
	
		if (plus'event and plus = '1') then 
			offset <= offset + 1;
		end if;
		
						  						 	  
	end process;
end offsetCounterArchitecture;
