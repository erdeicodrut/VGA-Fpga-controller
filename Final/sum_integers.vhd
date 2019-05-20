library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sum_integers is
	generic	(nr_range: integer :=56);
	port(
	term1: in integer range 0 to nr_Range - 1;
	term2: in integer range 0 to nr_Range - 1;
	result: out integer range 0 to nr_Range - 1
	);
end sum_integers;

architecture ARH of sum_integers is

begin
	result <= term1 + term2;
end ARH;
