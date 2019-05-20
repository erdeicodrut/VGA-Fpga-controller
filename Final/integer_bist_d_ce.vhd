library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity integer_bist_d_ce is
	generic(nr_range: integer);
	port(
	D: in integer range 0 to nr_range - 1;
	ce: in std_logic;
	clk: in std_logic;
	Q: out integer range 0 to nr_range - 1
	);
end integer_bist_d_ce;

architecture ARH of integer_bist_d_ce is

begin
	process(D, ce, clk)
	begin
		if(ce = '1') then
			if clk'event and clk = '1' then 
				Q <= D;
			end if;
		end if;
	end process;
end ARH;

			
	