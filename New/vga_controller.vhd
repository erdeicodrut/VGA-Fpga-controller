library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity vga_controller is
	port(
	clock: in std_logic;
	--reset_controller: in std_logic;
	h_sync: out std_logic := '1';
	v_sync: out std_logic := '1';		   
	display_enable: out std_logic := '1';
	row: out integer := 0;
	column: out integer := 0);
end vga_controller;

architecture vga_architecture of vga_controller is

signal h_display: integer := 640; --nr of pixel on a row of display
signal h_front_porch: integer := 16; --nr of pixel clocks for front porch of horizontal sync
signal h_back_porch: integer := 48; --nr of pixel clocks for back porch of horizontal sync
signal h_sync_pulse: integer := 96; --nr of pixel clocks for which horizontal sync is 0	
signal h_polarity: std_logic := '0'; --active state of horizontal sync

signal v_display: integer := 480; --nr of rows of diplay
signal v_front_porch: integer := 10; -- nr of rows for front porch of vertical sync
signal v_back_porch: integer := 33; --nr of rows for back porch of vertical sync
signal v_sync_pulse: integer := 2; --nr of rows for which vertical sync is 0
signal v_polarity: std_logic := '0'; --active state of horiontal sync
	
signal pixel_clock: std_logic;
	
component freq_divider is
	port(clk_in : in std_logic;
	resetDivider: in std_logic;
	clk_out : out std_logic);
end component ;

constant h_total_period: integer := h_front_porch + h_display + h_sync_pulse + h_back_porch; --total pixels clock for horizontal sync
constant v_total_period: integer := v_front_porch + v_display + v_sync_pulse + v_back_porch; --total rows for vertical sync
	
begin																	   
	DIVIDE: freq_divider port map (clock, '0', pixel_clock);

	process (pixel_clock)
	
	variable h_count: integer range 0 to h_total_period - 1 := 0; --current column
	variable v_count: integer range 0 to v_total_period - 1 := 0; --current row
	
	begin
		if pixel_clock'event and pixel_clock = '1' then --detect rising edge of pixel clock
			
			--update counters for horizontal and vertical sync
			if(h_count < h_total_period - 1) --update horizontal sync counter; check is end of line is reached or not
				then h_count := h_count + 1;
			else 
				h_count := 0; --start new line; must also update vertical sync counter
				if(v_count < v_total_period - 1) --update vertical sync counter; check is last row is reached or not	
					then v_count := v_count + 1;
				else v_count := 0;
				end if;
			end if;
			
			--update the horizontal and vertical sync signals
			if(h_count < h_display + h_front_porch or h_count >= h_display + h_front_porch + h_sync_pulse)
				then h_sync <= not h_polarity;
			else h_sync <= h_polarity;
			end if;
			
			if(v_count < v_display + v_front_porch or v_display >= v_display + v_front_porch + v_sync_pulse)
				then v_sync <= not v_polarity;
			else v_sync <= v_polarity;
			end if;
			
			--set pixels coordinates
			if(h_count < h_display)
				then column <= h_count;
			end if;
			
			if(v_count < v_display)
				then row <= v_count;
			end if;
			
			--set display enable
			if(h_count < h_display and v_count < v_display)
				then display_enable <= '1';
			else display_enable <= '0';
			end if;
			
		end if;		
	end process;
	
end vga_architecture;

	
	