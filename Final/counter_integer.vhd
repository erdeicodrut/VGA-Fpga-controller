library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter_for_integers is
	generic(max_value: integer := 53);
	port(
	clk: in std_logic;			
	count: inout integer := 0);
end counter_for_integers;

architecture ARH of counter_for_integers is

begin
	process(clk)
	begin
		if(clk'event and clk = '1')
			then
			if(count < max_value - 1)
				then count <= count + 1;
			else count <= 0;
			end if;
		end if;	
	end process;
end ARH;


	
		
	