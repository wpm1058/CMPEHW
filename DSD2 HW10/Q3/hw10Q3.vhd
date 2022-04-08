library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hw10Q3 is
	port (
		clk,rst : in std_logic;
		count_out1, count_out2 : out std_logic_vector(3 downto 0)
			);	
end entity hw10Q3;

architecture rtl of hw10Q3 is
	signal count_sig : unsigned(3 downto 0);
begin
	count_var_proc : process(clk)
		variable count_var : unsigned(3 downto 0) := "0000";
	begin
			if rising_edge(clk) then
				count_var := count_var+1;
				if count_var = "1000" then
					count_var := "0000";
				end if;
				count_out1 <= std_logic_vector(count_var);
			end if;
		end process;

	signal_var_proc : process (clock)
	begin
		if rising_edge(clk) then
		  	if (rst = '1') then
		    	count_sig <= "0000";
		  	elsif (count_sig <= "0111") then
				count_sig <= "0000";
			else
				count_sig <= count +1;
		  end if;
		end if;
	end process;
	count_out2 <= std_logic_vector(count_sig);
end architecture rtl;
