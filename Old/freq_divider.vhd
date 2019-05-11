library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity freq_divider is
	port(clk_in : in std_logic;
	resetDivider: in std_logic;
	clk_out : out std_logic);
end freq_divider;			 

architecture ARH of freq_divider is

component counter is
	generic	(nr_bits: integer);
	port(clock: in std_logic;		  
	reset: in std_logic;
	Q: inout std_logic_vector (nr_bits - 1 downto 0));
end component;

signal inter : std_logic_Vector (1 downto 0);

begin 										 
COUNT: counter generic map(2) port map (clk_in, resetDivider, inter);
clk_out <= inter (1);
end ARH;	

