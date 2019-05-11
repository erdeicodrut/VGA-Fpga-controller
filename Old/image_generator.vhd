library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity image_generator is
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
end image_generator;

architecture image_generator_architecture of image_generator is 											  
begin																										  
	process (x, y, xCenter, yCenter, image)														  
	variable size: integer := 120;
	variable xINT: integer := conv_integer(x);																  
	variable yINT: integer := conv_integer(y);																  
	variable xCenterINT: integer := conv_integer(xCenter);													  
	variable image_selection: integer := conv_integer(image);
	variable yCenterINT: integer := conv_integer(yCenter);
	begin
		case image_selection is
			when 0 =>
			if (((xInt - xCenterInt)	* (xInt - xCenterInt) +  (yInt - yCenterInt) * (yInt - yCenterInt)) > size * size ) then 
				R <= "0000";
				G <= "0000";
				B <= "0000";
			else 
				R <= "1111";
				G <= "1111";
				B <= "1111";
			end if;	 		
			
			when 1 => 
			if ( xInt > xCenter and xInt < xCenter + size and
				 yInt > yCenter and yInt < yCenter + size) then
				R <= "0000";
				G <= "0000";
				B <= "0000";
			else 
				R <= "1111";
				G <= "1111";
				B <= "1111";
			end if;
			
			when 2 => 
			if ( xInt > xCenter and xInt < xCenter + size * 2 and
				 yInt > yCenter and yInt < yCenter + size) then
				R <= "0000";
				G <= "0000";
				B <= "0000";
			else 
				R <= "1111";
				G <= "1111";
				B <= "1111";
			end if;
			
			when 3 => 
			if (xInt mod size = 0) then
				R <= "0000";
				G <= "0000";
				B <= "0000";
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
	end process;  
end image_generator_architecture;
