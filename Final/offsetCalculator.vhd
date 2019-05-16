library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity positionCalculator is 
	generic
	(
		maxRes: Integer
	);
	port 
	(						   					   				 	 
		tickPlus: in std_logic;
		tickMinus: in std_logic;
		pos: out Integer
	);
		
end positionCalculator;

architecture positionCalculatorArchitecture of positionCalculator is 

component offsetCounter is
	generic(
		numberRange: Integer
	);
	port(
		enable: in std_logic;
		plus: in std_logic;	
		offset: inout integer range 0 to numberRange - 1 := 0
	);
end component;											
						   				 
signal xMinus: integer := 0;
signal xPlus: integer := 0;
				   				  
signal enablePlus: std_logic := '0';
signal enableMinus: std_logic := '0';  

begin
																											 
	minus: offsetCounter generic map(maxRes) port map(enableMinus, tickMinus, xMinus);
	plus: offsetCounter generic map(maxRes) port map(enablePlus, tickPlus, xPlus);
	
	process(xMinus, xPlus)
	begin			
		--TODO think of position 
		if (xPlus < 0) then
			
		end if;
		
	end process;
	
	
end positionCalculatorArchitecture;