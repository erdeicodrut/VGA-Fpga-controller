library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity top_module is
	port(
	fpga_clock: in std_logic;				  
	imgBtn: in std_logic;
	
	btnLeft: in std_logic;
	btnRight: in std_logic;
	btnUp: in std_logic;
	btnDown: in std_logic;
	
	RIn: in std_logic_vector (3 downto 0);
	BIn: in std_logic_vector (3 downto 0);
	GIn: in std_logic_vector (3 downto 0);
	
	H_Sync: out std_logic;
	V_Sync: out std_logic;
	R: out std_logic_vector (3 downto 0);
	G: out std_logic_vector (3 downto 0);
	B: out std_logic_Vector (3 downto 0));
end top_module;

architecture ARH of top_module is

component freq_divider is
	port(clk_in : in std_logic;
	resetDivider: in std_logic;
	clk_out : out std_logic);
end component ;


component DU is
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
end component;

component vga_controller is
	port(
	pixel_clock: in std_logic;			  
	h_sync: out std_logic := '1';
	v_sync: out std_logic := '1';		   
	display_enable: out std_logic := '1';
	row: out integer := 0;
	column: out integer := 0);
end component ;					 

component positionCalculator is 
	generic
	(
		maxRes: Integer
	);
	port 
	(						   					   				 	 
		tickPlus: in std_logic;
		tickMinus: in std_logic;
		pos: inout Integer
	);
		
end component ;

component image_generator is 
	port(
	display_enable: in std_logic;
	row: in integer;
	column: in integer;
	image: in integer;
	
	x_coordinate: in integer;
	y_coordinate: in integer;
	
	Rin: in std_logic_vector (3 downto 0);
	Gin: in std_logic_vector (3 downto 0);
	Bin: in std_logic_vector (3 downto 0);
	
	R: out std_logic_vector (3 downto 0);
	G: out std_logic_vector (3 downto 0);
	B: out std_logic_vector (3 downto 0));
end component ;

component counter_for_integers is
	generic(max_value: integer := 53);
	port(
	clk: in std_logic;			
	count: inout integer := 0);
end component ;

signal image, left, right, up, down: std_logic;
signal image_number: integer;
signal row: integer;
signal column: integer;
signal display_enable: std_logic;

constant max_image: integer := 4; 
							   													 
signal offsetXPlus: Integer := 0;
signal offsetYPlus: Integer := 0;
signal offsetXMinus: Integer := 0;
signal offsetYMinus: Integer := 0;

signal pixel_clock: std_logic;
signal x,y: integer;


begin					   
DIVIDE: freq_divider port map (fpga_clock, '0', pixel_clock);

COUNT: counter_for_integers generic map (max_image) port map(image, image_number);

DEBOUNCE: DU port map (pixel_clock, imgBtn, btnLeft, btnRight, btnUp, btnDown, image, left, right, up, down);

POSITION: vga_controller port map (pixel_clock, H_Sync, V_Sync, display_enable, row, column);

X_AXIS: positionCalculator generic map (640) port map (right, left, x);
Y_AXIS: positionCalculator generic map (480) port map (down, up, y);

IMG: image_generator port map (
display_enable,
row, column,
image_number,
x,
y,
Rin, Gin, Bin,
R, G, B
);
end arh;