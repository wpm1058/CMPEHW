library ieee;
use ieee.std_logic_1164.all;

entity Q3 is
	port (
		clk,rst : in std_logic;
		Q : out std_logic_vector(2 downto 0)
			);	
end entity Q3;

architecture dataflow of Q3 is
	signal state: std_logic_vector(2 downto 0);
	signal nextstate: std_logic_vector(2 downto 0);
begin
	state : process (rst, clk)
	begin
	  	if (reset = '1') then
	 		state <= "000";
	  	elsif (rising_edge(clock)) then
			state <= nextstate;
	  	end if;
	end process state;

	nextstate : process (clk)
	begin
		case(state) is
			when "000" => nextstate <= "001";
			when "001" => nextstate <= "011";
			when "011" => nextstate <= "010";
			when "010" => nextstate <= "110";
			when "110" => nextstate <= "111";
			when "111" => nextstate <= "101";
			when "101" => nextstate <= "100";
			when "100" => nextstate <= "000";
			when others => nextstate <= "000";
		end case;
	end process nextstate;

	q <= state;
	
end architecture dataflow;
