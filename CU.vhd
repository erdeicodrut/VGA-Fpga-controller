library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity CU is
	port (imgBtn: in std_logic;
	leftBtn: in std_logic;
	rightBtn: in std_logic;
	upBtn: in std_logic;
	downBtn: in std_logic;
	clock: inout std_logic;
	image: out std_logic;
	left: out std_logic;
	right: out std_logic;
	up: out std_logic;
	down: out std_logic);
end CU;

architecture ARH of CU is

component debouncer is
	generic (nr_bistabile: integer);
	port (btn_in : in std_logic;
	clk: in std_logic; --internal clock
	btn_out: out std_logic);
end component ;

begin
	L1: debouncer generic map (5) port map (imgBtn, clock, image);
	L2: debouncer generic map (5) port map (leftBtn, clock, left);
	L3: debouncer generic map (5) port map (rightBtn, clock, right);
	L4: debouncer generic map (5) port map (upBtn, clock, up);
	L5: debouncer generic map (5) port map (downBtn, clock, down);
end ARH;
