library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity EU is
	port (clock: in std_logic;
	image: in std_logic;
	left: in std_logic;
	right: in std_logic;
	up: in std_logic;
	down: in std_logic;
	H_Sync: inout std_logic;
	V_Sync: inout std_logic;
	R: out std_logic_vector(3 downto 0);
	G: out std_logic_vector (3 downto 0);
	B: out std_logic_vector (3 downto 0));
end EU;

architecture ARH of EU is

signal X: std_logic_vector (9 downto 0);
signal Y: std_logic_vector (8 downto 0);
signal xCenter: std_logic_vector (9 downto 0);
signal yCenter: std_logic_vector (8 downto 0);

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

component position_generator is
	port (clock: in std_logic;
	H_Sync: inout std_logic;
	V_Sync: inout std_logic;		
	X: inout std_logic_vector (9 downto 0);
	Y: inout std_logic_vector (8 downto 0);
	image: in std_logic);
end component ;

begin
	POSITION: position_generator port map(clock, H_SYnc, V_Sync, X, Y, image);
	COLOR: image_generator port map(image, X, Y, xCenter, yCenter, R, G, B);
end ARH;
