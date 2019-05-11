library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity VGA is
	port(
	imgBtn: in std_logic;
	leftBtn: in std_logic;
	rightBtn: in std_logic;
	upBtn: in std_logic;
	downBtn: in std_logic;
	VGA_clock: in std_logic;
	H_Sync: inout std_logic;
	V_Sync: inout std_logic;
	R: out std_logic_vector (3 downto 0);
	G: out std_logic_vector (3 downto 0);
	B: out std_logic_vector (3 downto 0)
	);
end VGA;

architecture VGA_Architecture of VGA is

signal image, left, right, up, down : std_logic;
signal X: std_logic_vector (9 downto 0);
signal Y: std_logic_vector (8 downto 0);
signal xCenter:  std_logic_vector (9 downto 0);
signal yCenter: std_logic_vector (8 downto 0);
signal aux: std_logic_vector (1 downto 0);	
signal resetImage: std_logic;

component debounce_unit is
	generic (nr_bist_debouncer: integer);
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
end component ;

component position_generator is
	port (clock: in std_logic;
	H_Sync: inout std_logic;
	V_Sync: inout std_logic;		
	X: inout std_logic_vector (9 downto 0);
	Y: inout std_logic_vector (8 downto 0);
	image: in std_logic);
end component ;

component image_generator is
	port (													
		image: in std_logic_vector (1 downto 0);
									   						   
		x: in std_logic_vector (9 downto 0);
		y: in std_logic_vector (8 downto 0);
				   						   
		xCenter: in std_logic_vector (9 downto 0);
		yCenter: in std_logic_vector (8 downto 0);
		
		R: out std_logic_vector (3 downto 0); 
		G: out std_logic_vector (3 downto 0);
		B: out std_logic_vector (3 downto 0)
	
	);
end component ;										

component counter is
	generic	(nr_bits: integer);
	port(clock: in std_logic;		  
	reset: in std_logic;
	Q: inout std_logic_vector (nr_bits - 1 downto 0));
end component ;

begin				 
	xCenter <= "0010010110";
	yCenter <= "011111010";	
	resetImage <= '0';
DU: debounce_unit generic map (5) 
						port map (imgBtn, leftBtn, rightBtn, upBtn, downBtn, VGA_clock, image, left, right, up, down);
PG: position_generator port map (VGA_clock, H_Sync, V_Sync, X, Y, image);
COUNT_IMG: counter generic map (2) port map (image, resetImage, aux);
IG: image_generator port map (aux, x, y, xCenter, yCenter, R, G, B);
end VGA_Architecture;