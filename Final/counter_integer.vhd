library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter_for_integers is
	generic(max_value: integer := 53);
	port(
	clk: in std_logic;			
	count: inout integer range 0 to max_value - 1 := 0);
end counter_for_integers;

architecture ARH of counter_for_integers is

component comp_integers_lower is
	generic(number_range: integer);
	port(
	term1: in integer range 0 to number_range - 1;
	term2: in integer range 0 to number_range - 1;
	result: out std_logic
	);
end component ;

signal comparatie: std_logic;

begin
	
RESET: comp_integers_lower generic map (max_value) port map (count, max_value - 1, comparatie);
	process(clk)
	begin
		if(clk'event and clk = '1')
			then
			if comparatie = '1'
				then count <= count + 1;
			else count <= 0;
			end if;
		end if;	
	end process;
end ARH;