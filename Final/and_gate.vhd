																				library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity and_gate is
	generic(N: integer := 5);
	port(input: in std_logic_vector (1 to N);
	gate_output: out std_logic);
end and_gate;

architecture ARH of and_gate is

signal temp: std_logic_vector (1 to N + 1);

begin
	temp(1) <= '1';
	
	GEN_GATE:
	for i in 1 to N generate
		u1: temp(i+1) <= temp(i) and input(i);
	end generate GEN_GATE;
	
	gate_output <= temp(N+1);
end ARH;
