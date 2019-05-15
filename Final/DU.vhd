library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity DU is
	port(
	clock: in std_logic;
	imgBtn: in std_logic;
	leftBtn: in std_logic;
	rightBtn: in std_logic;
	upBtn: in std_logic;
	downBtn: in std_logic;
	image: out std_logic;
	left: out std_logic;
	right: out std_logic;
	up: out std_logic;
	down: out std_logic
	);
end DU;

architecture ARH of DU is

component debouncer is
	generic (nr_bistabile: integer);
	port (btn_in : in std_logic;
	clk: in std_logic; --internal clock
	btn_out: out std_logic);
end component ;

begin					
	
IMAGE_BTN: debouncer generic map (7) port map (imgBtn, clock, image);
LEFT_BTN: debouncer generic map (7) port map (leftBtn, clock, left);
RIGHT_BTN: debouncer generic map (7) port map (rightBtn, clock, right);
UP_BTN: debouncer generic map (7) port map (upBtn, clock, up);
DOWN_BTN: debouncer generic map (7) port map (downBtn, clock, down);

end ARH;
