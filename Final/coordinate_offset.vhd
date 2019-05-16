library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity offsetCounter is
	generic(
		numberRange: Integer
	);
	port(			   	   
		enable: in std_logic;
		plus: in std_logic;
		offset: inout integer range 0 to numberRange - 1 := 0
	);
end offsetCounter;

architecture offsetCounterArchitecture of offsetCounter is	 

begin
	process(plus, offset, enable)
	begin	   	   	  
		if (plus'event and plus = '1' and enable = '1') then 
			offset <= offset + 1;
		end if;
		
						  						 	  
	end process;
end offsetCounterArchitecture;
