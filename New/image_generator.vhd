library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity image_generator is 
	port(
	display_enable: in std_logic;
	row: in integer;
	column: in integer;
	R: out std_logic_vector (3 downto 0);
	G: out std_logic_vector (3 downto 0);
	B: out std_logic_vector (3 downto 0));
end image_generator;

architecture ARH of image_generator is

signal x_top_left: integer := 150; --x coordinate of top left corner of a square
signal y_top_left: integer := 150; --y coordinate of top left corner of a square
signal edge: integer := 120; --size of the edge of a square


begin
	process(display_enable, row, column)
	begin		
		if display_enable = '1' then
			if (row < x_top_left or row > x_top_left + edge) and (column < y_top_left or column > y_top_left + edge)
				then 
				R <= (others => '0');
				G <= (others => '0');
				B <= (others => '1');
			else					 
				R <= (others => '0');
				G <= (others => '1');
				B <= (others => '0');
			end if;
		else
			R <= (others => '0');
			G <= (others => '0');
			B <= (others => '0');
		end if;
		
			
				
				
				
	end process;
end arh;


	
	