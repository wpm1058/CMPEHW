library ieee;
use ieee.std_logic_1164.all;

entity hw10Q2 is
	port (
		s,r : in std_logic;
		q 	: out std_logic
	);
end hw10Q2;

architecture behave of he10Q2 is
	signal q_int : std_logic;
begin
	sr_latch: process  (s,r) is begin
		if s='0' and r='0' then
			q_int <= q_int;
		elsif s='0' and r='1' then
			q_int <= '0';
		elsif s='1' and r='0' then
			q_int <= '1';
		end if;
	end process;
	q <= q_int;
end architecture behave;
