library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity hw9Q1TB is	
end entity hw9Q1TB;

architecture bench of hw9Q1TB is
	signal a: std_logic_vector(3 downto 0);
	signal y: std_logic;
	file vector_file : text open READ_MODE is "text.txt";
begin
	uut: entity work.fourXOR 
	port map (
		a => a,
		y => y
	);
	stimulus: process
		variable vector_line : line;
		variable vector_valid: boolean;
		variable v_a_in : std_logic_vector(3 downto 0);
		variable v_y_out: std_logic;
	begin
			while not endfile(vector_file) loop
		-- ADD: read a line from the vector file
			readline(vector_file,vector_line);
		-- reads v_a_in
			read(vector_line,v_a_in,good => vector_valid);
		-- exit loop if vector_valid false which happens when the line starts with #
			next when not vector_valid;
			a <= v_a_in;
			wait for 10 ns;
		-- ADD: read v_y_out, the expected output
			read(vector_line,v_y_out,good =>vector_valid);
			assert (y = v_y_out) report "error in operation at "
			& time'image(now) " a = " & to_hstring(a) & " and y = "
			& std_logic'image(y);
			wait for 10 ns;
		end loop;
		report "testing complete";
		wait;
	end process;
end architecture bench;
