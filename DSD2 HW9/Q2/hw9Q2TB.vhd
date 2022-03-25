library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
use ieee.std_logic_textio.all;

entity hw9Q2TB is	
end entity hw9Q2TB;

architecture tb of hw9Q2TB is
	signal data: std_logic_vector(3 downto 0);
	signal segments: std_logic_vector(6 downto 0);
	file vector_file : text open read_mode is "test.txt";
begin
	uut: entity work.sevSeg 
		port map (
			data => data,
			segments => segments
		);
	stimulus: process
		variable vector_line : line;
		variable vector_valid: boolean;
		variable v_data_in : std_logic_vector(3 downto 0);
		variable v_segments_out : std_logic_vector(6 downto 0);
	begin
		test : while (not endfile(vector_file)) loop
		-- ADD: read a line from the vector file
			readline(vector_file,vector_line);
		-- reads v_a_in
			read(vector_line,v_data_in,good => vector_valid);
		-- exit loop if vector_valid false which happens when the line starts with #
			next when not vector_valid;
			data <= v_data_in;
			wait for 10 ns;
		-- ADD: read v_y_out, the expected output
			read(vector_line,v_segments_out,good =>vector_valid);
			assert (segments = v_segments_out) report "error in operation at "
			& time'image(now) & " data = " & to_hstring(data) & " and segments = "
			& to_hstring(segments);
			wait for 10 ns;	
		end loop test;
		report "testing complete";
		wait;
	end process;
end architecture tb;
