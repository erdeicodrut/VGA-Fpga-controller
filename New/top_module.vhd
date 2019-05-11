library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity top_module is
	port(
	fpga_clock: in std_logic;				  
	H_Sync: out std_logic;
	V_Sync: out std_logic;
	R: out std_logic_vector (3 downto 0);
	G: out std_logic_vector (3 downto 0);
	B: out std_logic_Vector (3 downto 0));
end top_module;

architecture ARH of top_module is

component vga_controller is
	port(
	clock: in std_logic;
	--reset_controller: in std_logic;
	h_sync: out std_logic := '1';
	v_sync: out std_logic := '1';		   
	display_enable: out std_logic := '1';
	row: out integer := 0;
	column: out integer := 0);
end component ;

component image_generator is 
	port(
	display_enable: in std_logic;
	row: in integer;
	column: in integer;
	R: out std_logic_vector (3 downto 0);
	G: out std_logic_vector (3 downto 0);
	B: out std_logic_vector (3 downto 0));
end component ;

signal row: integer;
signal column: integer;
signal display_enable: std_logic;

begin	
POSITION: vga_controller port map (fpga_clock, H_Sync, V_Sync, display_enable, row, column);
IMAGE: image_generator port map (display_enable, row, column, R, G, B);
end arh;