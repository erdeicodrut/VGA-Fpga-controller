library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity comp_egal is
	generic	(nr_bits: integer);
	port (A: in std_logic_vector(nr_bits - 1 downto 0);
	B: in std_logic_vector(nr_bits - 1 downto 0);
	egal: out std_logic);
end comp_egal;												 								    

architecture ARH of comp_egal is

signal aux: std_logic_vector(nr_bits -1 downto 0);

component and_gate is
	generic(N: integer := 5);
	port(input: in std_logic_vector (1 to N);
	gate_output: out std_logic);
end component ;

begin
	GEN_XOR: for i in nr_bits - 1 downto 0 generate
		L1: aux(i) <= A(i) xor B(i);
	end generate GEN_XOR;
	
	GATE_AND: and_gate generic map (nr_bits) port map(aux, egal);
end ARH;
