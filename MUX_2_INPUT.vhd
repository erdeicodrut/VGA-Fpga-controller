library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity mux2 is
	generic (nr_bits: integer);
	port(input0: in std_logic_vector (nr_bits - 1 downto 0);
	input1: in std_logic_vector (nr_bits - 1 downto 0);
	sel: in std_logic;
	output: out std_logic_vector(nr_bits - 1 downto 0));
end mux2;								

architecture ARH of mux2 is

begin
	process(sel, input0, input1)
	begin
		if sel = '0' then output <= input0;
		else output <= input1;
		end if;
	end process;
end ARH;
	
