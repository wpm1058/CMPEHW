library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Q3TB is
end Q3TB;

architecture tb of Q3TB is
	type testRecord is record
		binary, gray : std_logic_vector(2 downto 0);
	end record;
	type testRecordArray is array (natural range <>) of testRecord;
	constant ctest : testRecordArray := (("000","000"),("001","001"),
		("010","011"),("011","010"),("100","110"),
		("101","111"),("110","101"),("111","1000"));
	constant clk_period : time := 10 ns;
	signal clk, rst : std_logic := '1';
	signal q : std_logic_vector(2 downto 0);
begin
	uut: entity work.Q3 port map (
		clk => clk, rst => rst, Q => Q
	);
	clk <= not clk after clk_period/2;
	stimulus : process
	begin
		rst <= '1';
		wait for clk_period;
		wait until falling_edge(clk);
		rst <= '0';

		for i in ctest'range loop
			wait until rising_edge(clk);
			assert (q = ctest(i).gray) report "error in test number " & integer'image(i)
			& ", binary value = " & to_hstring(ctest(i).binary) & ", expected gray value = " 
			& to_hstring(ctest(i).gray) & ", counter gray value = " & to_hstring(q);
		end loop;
		wait;
	end process stimulus;
end architecture tb;