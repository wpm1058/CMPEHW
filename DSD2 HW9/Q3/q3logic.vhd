library ieee;
use ieee.std_logic_1164.all;

entity q3logic is
	port (
		a,b,c : in std_logic;
		y 	  : out std_logic
	);
end q3logic;

architecture dataflow of q3logic is
begin
	y <= (a and (not b)) or ((not b) and (not c)) or ((not a) and b and c);
end architecture dataflow;

