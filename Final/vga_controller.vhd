library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity vga_controller is
	port(
	pixel_clock: in std_logic;
	h_sync: out std_logic := '1';
	v_sync: out std_logic := '1';		   
	display_enable: out std_logic := '1';
	row: out integer range 0 to 639:= 0;
	column: out integer range 0 to 639:= 0);
end vga_controller;

architecture vga_architecture of vga_controller is

constant h_display: integer := 640; --nr of pixel on a row of display
constant h_front_porch: integer := 16; --nr of pixel clocks for front porch of horizontal sync
constant h_back_porch: integer := 48; --nr of pixel clocks for back porch of horizontal sync
constant h_sync_pulse: integer := 96; --nr of pixel clocks for which horizontal sync is 0	

constant v_display: integer := 480; --nr of rows of diplay
constant v_front_porch: integer := 10; -- nr of rows for front porch of vertical sync
constant v_back_porch: integer := 29; --nr of rows for back porch of vertical sync
constant v_sync_pulse: integer := 2; --nr of rows for which vertical sync is 0

constant h_total_period: integer := h_front_porch + h_display + h_sync_pulse + h_back_porch; --total pixels clock for horizontal sync
constant v_total_period: integer := v_front_porch + v_display + v_sync_pulse + v_back_porch; --total rows for vertical sync
constant h_first_part: integer := h_display + h_front_porch;
constant h_last_part: integer := h_display + h_front_porch + h_sync_pulse - 1;
constant v_first_part: integer := v_display + v_front_porch;
constant v_last_part: integer := v_display + v_front_porch + v_sync_pulse - 1;
	
component counter_for_integers is
	generic(max_value: integer);
	port(
	clk: in std_logic;			
	count: inout integer);
end component;						   

component comp_integers_lower is
	generic(number_range: integer);
	port(
	term1: in integer range 0 to number_range - 1;
	term2: in integer range 0 to number_range - 1;
	result: out std_logic
	);
end component ;

component BIST_D is
	port(D: in std_logic;
	clk: in std_logic;
	Q: out std_logic);
end component ;

component integer_bist_d_ce is
	generic(nr_range: integer);
	port(
	D: in integer range 0 to nr_range - 1;
	ce: in std_logic;
	clk: in std_logic;
	Q: out integer range 0 to nr_range - 1
	);
end component ;

signal h_count: integer range 0 to h_total_period - 1 := 0; --current column
signal v_count: integer range 0 to v_total_period - 1 := 0; --current row
signal v_sync_clock: std_logic := '0';
signal h_positive1, h_positive2, v_positive1, v_positive2 : std_logic;
signal h_aux, v_aux: std_logic;
signal column_enable, row_enable: std_logic;
signal h_sync_input, v_sync_input: std_logic;
signal v_sync_clock_input: std_logic;
signal display_enable_input: std_logic;
		
	
begin													
COUNT_HORIZONTAL: counter_for_integers generic map (h_total_period) port map (pixel_clock, h_count);
COUNT_VERTICAL: counter_for_integers generic map (v_total_period) port map (v_sync_clock, v_count);

H_PART1: comp_integers_lower generic map (h_total_period) port map (h_count, h_first_part, h_positive1);
H_PART2: comp_integers_lower generic map (h_total_period) port map (h_last_part, h_count, h_positive2);							   
V_PART1: comp_integers_lower generic map (v_total_period) port map (v_count, v_first_part, v_positive1);
--V_PART2: comp_integers_lower generic map (v_total_period) port map (v_last_part, v_count, v_positive2);

C_ENABLE: comp_integers_lower generic map (h_total_period) port map (h_count, h_display, column_enable);
R_ENABLE: comp_integers_lower generic map (v_total_period) port map (v_count, v_display, row_enable);																		   														 

HSYNC_FF: bist_d port map (h_sync_input, pixel_clock, h_sync);
VSYNC_FF: bist_d port map (v_sync_input, pixel_clock, v_sync);
DISPLAY_FF: bist_d port map (display_enable_input, pixel_clock, display_enable);
VSYNCCLOCK_FF: bist_d port map(v_sync_clock_input, pixel_clock, v_sync_clock);

ROWS: integer_bist_d_ce generic map (v_total_period) port map (v_count, row_enable, pixel_clock, row); 
COLUMNS: integer_bist_d_ce generic map (h_total_period) port map (h_count, column_enable, pixel_clock, column);

--h_positive2 <= not h_aux;								   
--v_positive2 <= not v_aux;
h_sync_input <= h_positive1 or h_positive2;
v_sync_input <= v_positive1;-- or v_positive2;
v_sync_clock_input <= not h_sync_input;		
display_enable_input <= column_enable and row_enable;

				
	
end vga_architecture;

	
	