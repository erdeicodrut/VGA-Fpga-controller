library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity BIST_D is
	port(D: in std_logic;
	clk: in std_logic;
	Q: out std_logic);
end BIST_D;

architecture ARh of bist_d is

begin
	process(clk)
	begin
		if clk'event and clk = '1' then Q <= D;
		end if;
	end process;
end ARH;
