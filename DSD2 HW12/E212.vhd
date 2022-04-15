library ieee;
use ieee.std_logic_1164.all;

entity E212 is
	port (
		g1,g2n :in std_logic;
		CBAsel : in std_logic_vector(2 downto 0);
		y : out std_logic_vector(7 downto 0)
	);
end E212;

architecture E212_arc of E212 is
begin
	decode_proc: process(all) is begin
		if (G1 and not G2n) then
			case (CBAsel) is
				when 3ux"0" => Y <= "11111110";
				when 3ux"1" => Y <= "11111101";
				when 3ux"2" => Y <= "11111011";
				when 3ux"3" => Y <= "11110111";
				when 3ux"4" => Y <= "11101111";
				when 3ux"5" => Y <= "11011111";
				when 3ux"6" => Y <= "10111111";
				when others => Y <= "01111111";
					null;
			end case;
		else 
			Y <= "11111111";
		end if;
	end process;
end E212_arc;