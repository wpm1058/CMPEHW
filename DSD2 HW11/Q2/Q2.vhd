library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Q2 is
	port (
		A,B,rst,clk : in std_logic;
		Q : out std_logic
	);
end;

architecture Q2_arc of Q2 is
	type state is (S0,S1,S2);
	signal cur_state, nxt_state : state;
begin
	-- default state
	state_proc : process (rst, clk) is begin
		if (rising_edge(clk)) then
	  		if (rst = '1') then
				cur_state <= S0;	 
	  		else
				cur_state <= nxt_state;
			end if;
	  	end if;
	end process state_proc;

	--nxt state logic
	next_state_proc : process (cur_state, A, B) is begin
		case(cur_state) is
			when S0 => 
				if (A = '1') then
					nxt_state <= S1;
				else
					nxt_state <= S0;
				end if;
			when S1 =>
				if (B = '1') then
					nxt_state <= S2;
				else
					nxt_state <= S0;
				end if;
			when S2 =>
				nxt_state <= S0;
			when others =>
				nxt_state <= S0;
		end case;
	end process next_state_proc;

	-- output logic
	output : process (rst, clk, A, B)
	begin
		case(cur_state) is
			when S0 => 
				Q <= '0';
			when S1 =>
				Q <= '0';
			when S2 =>
				Q <= '1';
			when others =>
				Q <= '1';
		end case;
	end process output;
end Q2_arc;

