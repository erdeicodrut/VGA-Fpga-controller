library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity debounce_unit is
	generic (nr_bist_debouncer: integer := 5);
	port (imgBtn: in std_logic;
	leftBtn: in std_logic;
	rightBtn: in std_logic;
	upBtn: in std_logic;
	downBtn: in std_logic;
	clock: in std_logic;
	image: out std_logic;
	left: out std_logic;
	right: out std_logic;
	up: out std_logic;
	down: out std_logic);
end debounce_unit;

architecture ARH of debounce_unit is

component debouncer is
	generic (nr_bistabile: integer);
	port (btn_in : in std_logic;
	clk: in std_logic; --internal clock
	btn_out: out std_logic);
end component ;

begin
	L1: debouncer generic map (nr_bist_debouncer) port map (imgBtn, clock, image);
	L2: debouncer generic map (nr_bist_debouncer) port map (leftBtn, clock, left);
	L3: debouncer generic map (nr_bist_debouncer) port map (rightBtn, clock, right);
	L4: debouncer generic map (nr_bist_debouncer) port map (upBtn, clock, up);
	L5: debouncer generic map (nr_bist_debouncer) port map (downBtn, clock, down);
end ARH;
