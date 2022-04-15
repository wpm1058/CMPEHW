library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity E212TB is
end E212TB;

architecture E212TB_arc of E212TB is
	signal g1,g2n : std_logic := '0';
	signal CBAsel : std_logic_vector(2 downto 0) := (others => '0');
	signal y : std_logic_vector(7 downto 0);

begin
	uut: entity work.E212 port map (
		g1 => g1,
		g2n => g2n,
		CBAsel => CBAsel,
		y => y
	);

	stimulus : process
		variable expected_y : std_logic_vector(7 downto 0);
	begin
		expected_y := "11111111";
		g1 <= '0'; 
		g2n <= '0';
		wait for 10 ns;
		assert y = expected_y report "enables low error";

		g1 <= '0';
		g2n <= '1';
		wait for 10 ns;
		assert y = expected_y report "enable g1 low, g2n high error";

		g1 <='1';
		g2n <= '0';
		for i in 0 to 7 loop
		 	CBAsel <= std_logic_vector(to_unsigned(i, 3));
		 	expected_y := "11111111";
		 	expected_y(i) := '0';
		 	wait for 10 ns;
		 	assert y = expected_y report "i = " & integer'image(i) & "error";
		 	report "y = " & to_hstring(y);
		 	wait for 10 ns;
		end loop; 
		expected_y := "11111111";
		g1 <= '1'; 
		g2n <= '1';
		wait for 10 ns;
		assert (y = expected_y) report "enable g1 high, g2n high error";
		wait;
	end process stimulus;
end E212TB_arc;