library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity vga_controller is
	port(
	pixel_clock: in std_logic;
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

signal v_display: integer := 480; --nr of rows of diplay
signal v_front_porch: integer := 10; -- nr of rows for front porch of vertical sync
signal v_back_porch: integer := 33; --nr of rows for back porch of vertical sync
signal v_sync_pulse: integer := 2; --nr of rows for which vertical sync is 0
	
signal v_sync_clock: std_logic := '0';
	
component counter_for_integers is
	generic(max_value: integer);
	port(
	clk: in std_logic;			
	count: inout integer);
end component;

constant h_total_period: integer := h_front_porch + h_display + h_sync_pulse + h_back_porch; --total pixels clock for horizontal sync
constant v_total_period: integer := v_front_porch + v_display + v_sync_pulse + v_back_porch; --total rows for vertical sync

signal h_count: integer range 0 to h_total_period - 1 := 0; --current column
signal v_count: integer range 0 to v_total_period - 1 := 0; --current row
		
	
begin													
COUNT_HORIZONTAL: counter_for_integers generic map (h_total_period) port map (pixel_clock, h_count);
COUNT_VERTICAL: counter_for_integers generic map (v_total_period) port map (v_sync_clock, v_count);

	process (pixel_clock)
	
	begin
		if pixel_clock'event and pixel_clock = '1' then --detect rising edge of pixel clock
			
			
			--update the horizontal and vertical sync signals
			if(h_count < h_display + h_front_porch or h_count >= h_display + h_front_porch + h_sync_pulse)
				then h_sync <= '1';
					v_sync_clock <= '0';
			else h_sync <= '0';			
				v_sync_clock <= '1';
			end if;
			
			if(v_count < v_display + v_front_porch or v_display >= v_display + v_front_porch + v_sync_pulse)
				then v_sync <= '1';
			else v_sync <= '0';
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

	
	