library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity image_generator is
	port (
		image_selection: in integer range 0 to 3;
									   						   
		x: in std_logic_vector (9 downto 0);
		y: in std_logic_vector (9 downto 0);
				   						   
		xCenter: in std_logic_vector (9 downto 0);
		yCenter: in std_logic_vector (9 downto 0);
		
		R: out std_logic_vector (7 downto 0); 
		G: out std_logic_vector (7 downto 0);
		B: out std_logic_vector (7 downto 0)
	
	);
end image_generator;

architecture image_generator_architecture of image_generator is 											  
begin																										  
	process (x, y, xCenter, yCenter, image_selection)														  
	variable size: integer := 120;
	variable xINT: integer := conv_integer(x);																  
	variable yINT: integer := conv_integer(y);																  
	variable xCenterINT: integer := conv_integer(xCenter);
	variable yCenterINT: integer := conv_integer(yCenter);
	begin
		case image_selection is
			when 0 =>
			if (((xInt - xCenterInt)	* (xInt - xCenterInt) +  (yInt - yCenterInt) * (yInt - yCenterInt)) > size * size ) then 
				R <= "00000000";
				G <= "00000000";
				B <= "00000000";
			else 
				R <= "11111111";
				G <= "11111111";
				B <= "11111111";
			end if;	 		
			
			when 1 => 
			if ( xInt > xCenter and xInt < xCenter + size and
				 yInt > yCenter and yInt < yCenter + size) then
				R <= "00000000";
				G <= "00000000";
				B <= "00000000";
			else 
				R <= "11111111";
				G <= "11111111";
				B <= "11111111";
			end if;
			
			when 2 => 
			if ( xInt > xCenter and xInt < xCenter + size * 2 and
				 yInt > yCenter and yInt < yCenter + size) then
				R <= "00000000";
				G <= "00000000";
				B <= "00000000";
			else 
				R <= "11111111";
				G <= "11111111";
				B <= "11111111";
			end if;
			
			when 3 => 
			if (xInt mod size = 0) then
				R <= "00000000";
				G <= "00000000";
				B <= "00000000";
			else 
				R <= "11111111";
				G <= "11111111";
				B <= "11111111";
			end if;
			
			when others => 		
				R <= "11111111";
				G <= "11111111";
				B <= "11111111";
		end case; 
	end process;  
end image_generator_architecture;
