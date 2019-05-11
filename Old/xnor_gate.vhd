library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity xnor_gate is
	generic (N: integer := 5);
	port(A: in std_logic_vector(N-1 downto 0);
	B: in std_logic_vector(N-1 downto 0);
	output: out std_logic_vector (N-1 downto 0));
end xnor_gate;


architecture ARH of xnor_gate is

begin 				  						   			
	GEN_GATE:
	for i in N - 1 downto 0 generate
		L1: output(i) <= A(i) xnor B(i);
	end generate GEN_GATE;
	
end ARH;
