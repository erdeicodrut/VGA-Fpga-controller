library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity comp_egal is
	generic	(nr_bits: integer := 5);
	port (A: in std_logic_vector(nr_bits - 1 downto 0);
	B: in std_logic_vector(nr_bits - 1 downto 0);
	egal: out std_logic);
end comp_egal;												 								    

architecture ARH of comp_egal is

signal aux: std_logic_vector(nr_bits -1 downto 0);

component xnor_gate is
	generic (N: integer);
	port(A: in std_logic_vector(N-1 downto 0);
	B: in std_logic_vector(N-1 downto 0);
	output: out std_logic_vector (N-1 downto 0));
end component ;

component and_gate is
	generic(N: integer);
	port(input: in std_logic_vector (1 to N);
	gate_output: out std_logic);
end component ;

begin
	GATE_XNOR: xnor_gate generic map (nr_bits) port map (A, B, aux);
	GATE_AND: and_gate generic map (nr_bits) port map(aux, egal);
end ARH;
