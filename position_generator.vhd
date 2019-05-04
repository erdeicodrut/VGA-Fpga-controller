library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity position_generator is
	port (clock: in std_logic;
	H_Sync: inout std_logic;
	V_Sync: inout std_logic;		
	X: inout std_logic_vector (9 downto 0);
	Y: inout std_logic_vector (8 downto 0);
	image: in std_logic);
end position_generator;		 

architecture ARH of position_generator is 

signal pixel_clock, resetX, inter: std_logic;		

component freq_divider is
	port(clk_in : in std_logic;
	clk_out : out std_logic);
end component ;

component counter is
	generic	(nr_bits: integer);
	port(clock: in std_logic;		  
	reset: in std_logic;
	Q: inout std_logic_vector (nr_bits - 1 downto 0));
end component ;	  

component comp_egal is
	generic	(nr_bits: integer);
	port (A: in std_logic_vector(nr_bits - 1 downto 0);
	B: in std_logic_vector(nr_bits - 1 downto 0);
	egal: out std_logic);
end component ;

begin
	DIVIDER: freq_divider port map (clock, pixel_clock);
	COUNT_X: counter generic map (10) port map (pixel_clock, resetX, X);
	COMPARE_X: comp_egal generic map(10) port map (X, "1010000000", H_Sync);
	COUNT_Y: counter generic map (9) port map (H_Sync, V_Sync, Y);
	COMPARE_Y: comp_egal generic map (9) port map (Y, "111100000", inter);
	
	RESET_COUNT_X: resetX <= H_Sync or image;
	VERT_SYNC: V_Sync <= inter or image;
	
end ARH;
