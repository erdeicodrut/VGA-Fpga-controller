library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity image_generator is 
	port(
	display_enable: in std_logic;
	row: in integer;
	column: in integer;
	image: in integer;
	
	x_coordinate: in integer;
	y_coordinate: in integer;
	
	R: out std_logic_vector (3 downto 0);
	G: out std_logic_vector (3 downto 0);
	B: out std_logic_vector (3 downto 0));
end image_generator;

architecture ARH of image_generator is
																					  
signal size: integer := 130; --size of the edge of a square


begin
	process(display_enable, row, column, x_coordinate, y_coordinate)
	begin		
		if display_enable = '1' then
			case image is
				when 0 =>
			if (((column - x_coordinate) * (column - x_coordinate) +  (row - y_coordinate) * (row - y_coordinate)) < size * size) then 
				R <= "0000";
				G <= "0000";
				B <=  (others => '1');
			else 
				R <= "1111";
				G <= "1111";
				B <= "1111";
			end if;	 		
			
			when 1 => 
			if ( column > x_coordinate and column < x_coordinate + size and
				 row > y_coordinate and row < y_coordinate + size) then
				R <= "0000";
				G <= "0000";
				B <= (others => '1');
			else 
				R <= "1111";
				G <= "1111";
				B <= "1111";
			end if;
			
			when 2 => 
			if ( column > x_coordinate and column < x_coordinate + size * 2 and
				 row > y_coordinate and row < y_coordinate + size) then
				R <= "0000";
				G <= "0000";
				B <= (others => '1');
			else 
				R <= "1111";
				G <= "1111";
				B <= "1111";
			end if;
			
			when 3 => 
			if (column mod size = 0) then
				R <= "0000";
				G <= "0000";
				B <= (others => '1');
			else 
				R <= "1111";
				G <= "1111";
				B <= "1111";
			end if;
			
			when others => 		
				R <= "1111";
				G <= "1111";
				B <= "1111";
			end case; 	
		else
			R <= (others => '0');
			G <= (others => '0');
			B <= (others => '0');
		end if;
	end process;
end arh;


	
	