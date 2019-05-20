library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity comp_integers_lower is
	generic(number_range: integer);
	port(
	term1: in integer range 0 to number_range - 1;
	term2: in integer range 0 to number_range - 1;
	result: out std_logic
	);
end comp_integers_lower;

architecture ARH of comp_integers_lower is
begin
	process(term1, term2)
	begin
		if term1 < term2 then result <= '1';
		else result <= '0';
		end if;								  
	end process;
end ARH;
	