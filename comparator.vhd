library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity comparator is
	port(A: in integer;
	B: in integer;
	less: out std_logic;
	equal: out std_logic;
	greater: out std_logic);
end comparator;

architecture comparator_architecture of comparator is

begin
process (A, B)
	begin
	if A = B then
		equal <= '1';
		greater <= '0';
		less <= '0';
	
	elsif A > B	then
		equal <= '0';
		greater <= '1';
		less <= '0'; 
	elsif B > A then
		equal <= '0';
		greater <= '0';
		less <= '1';
	end if; 
end process;
	
end comparator_architecture;
