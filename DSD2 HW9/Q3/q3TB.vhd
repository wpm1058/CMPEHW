library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
use ieee.std_logic_textio.all;

entity q3TB is	
end entity q3TB;

architecture tb of q3TB is
	signal a 	: std_logic;
	signal b 	: std_logic;
	signal c 	: std_logic;
	signal y 	: std_logic;
	file vector_file : text open read_mode is "test.txt";
begin
	uut: entity work.q3logic
		port map (
			a => a,
			b => b,
			c => c,
			y => y
		);
	stimulus: process
		variable vector_line : line;
		variable vector_valid: boolean;
		variable v_a_in : std_logic;
		variable v_b_in : std_logic;
		variable v_c_in : std_logic;
		variable v_y_out : std_logic;
	begin
		test : while (not endfile(vector_file)) loop
		-- ADD: read a line from the vector file
			readline(vector_file,vector_line);
		-- reads v_a_in
			read(vector_line,v_a_in,good => vector_valid);
		-- exit loop if vector_valid false which happens when the line starts with #
			next when not vector_valid;
			a <= v_a_in;
			wait for 10 ns;
			read(vector_line,v_b_in,good => vector_valid);
		-- exit loop if vector_valid false which happens when the line starts with #
			next when not vector_valid;
			b <= v_b_in;
			wait for 10 ns;
			read(vector_line,v_c_in,good => vector_valid);
		-- exit loop if vector_valid false which happens when the line starts with #
			next when not vector_valid;
			c <= v_c_in;
			wait for 10 ns;
		-- ADD: read v_y_out, the expected output
			read(vector_line,v_y_out,good =>vector_valid);
			assert (y = v_y_out) report "error in operation at "
			& time'image(now) & " a = " & std_logic'image(a) 
			& " b = " & std_logic'image(b) 
			& " c = " & std_logic'image(c) & " and segments = "
			& std_logic'image(y);
			wait for 10 ns;	
		end loop test;
		report "testing complete";
		wait;
	end process;
end architecture tb;
