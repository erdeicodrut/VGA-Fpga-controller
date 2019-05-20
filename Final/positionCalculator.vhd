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
		pos: inout Integer
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
						   				 
signal posMinus: integer := 0;
signal posPlus: integer := 0;
				   				  
signal enablePlus: std_logic := '1';
signal enableMinus: std_logic := '1'; 

CONSTANT OFFSET : INTEGER := 130; 

begin
																											 
	minus: offsetCounter generic map(maxRes) port map(enableMinus, tickMinus, posMinus);
	plus: offsetCounter generic map(maxRes) port map(enablePlus, tickPlus, posPlus);
								  
	pos <= posPlus - posMinus;
	
	process(pos)
	begin						  
		if (pos >  maxRes - 130) then 
			enablePlus <= '0';
		else
			enablePlus <= '1';
		end if;				  
		
		if (pos < 0) then 
			enableMinus <= '0';
		else
			enableMinus <= '1';
		end if;				  
		
		
	end process;
	
	
end positionCalculatorArchitecture;