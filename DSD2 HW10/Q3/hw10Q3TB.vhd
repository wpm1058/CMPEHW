library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hw10Q3TB is
end hw10Q3TB;

architecture hw10Q3TB_arc of hw10Q3TB is
	signal clk, rst : std_logic := '1';
	signal count_out1, count_out2: std_logic_vector(3 downto 0);
	constant clk_period: time := 10 ns;
begin
	uut: entity work.hw10Q3 is
		port map (
			clk => clk,
			rst => rst,
			count_out1 => count_out1,
			count_out2 => count_out2
		);

		clk <= not clk after clk_period/2;

		rst <= '0' after 30 ns;
end hw10Q3TB_arc;
