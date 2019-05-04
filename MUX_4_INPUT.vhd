library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity mux4 is
	generic (nr_bits: integer := 3);
	port(input0: in std_logic_vector (nr_bits - 1 downto 0);
	input1: in std_logic_vector (nr_bits - 1 downto 0);
	input2: in std_logic_vector (nr_bits - 1 downto 0);
	input3: in std_logic_vector (nr_bits - 1 downto 0);
	output: out std_logic_vector (nr_bits - 1 downto 0);
	sel: in std_logic_vector (1 downto 0));
end mux4;

architecture ARH of mux4 is

begin
	process(input0, input1, input2, input3, sel)
	begin
		case SEL is
			when "00" => output <= input0;
			when "01" => output <= input1;
			when "10" => output <= input2;
			when "11" => output <= input3;
			when others => output <= (others => 'X');
		end case;
	end process;
end arh;
