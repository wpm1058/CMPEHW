library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity Q2TB is	
end entity Q2TB;

architecture TB of Q2TB is
	signal clk, rst, A, B: std_logic := '0';
	signal Q : std_logic;
	constant clk_period : time := 10 ns;
begin
	uut: entity work.Q2 port map (
		clk => clk, rst => rst, A => A, B => B, Q => Q
	);

	clk <= not clk after clk_period/2;

	stimulus : process
		variable seed1, seed2 : integer := 999;
		variable expected_state : integer := 0;
		variable expected_q : std_logic := '0';
		variable q_cover_cnt : integer := 0;

		impure function rand_slv(len : integer) return std_logic_vector is 
			variable rand : real;
			variable slv : std_logic_vector(len-1 downto 0);
	begin
		for i in slv'range loop
			uniform(seed1, seed2, rand);
			if rand > 0.5 then
				slv(i) := '1';
			else
				slv(i) := '0';
			end if;
		end loop;
		return slv;
		end function;
	begin
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		wait until falling_edge(clk);

		test_loop : loop
			(A,B) <= rand_slv(2);
			wait until rising_edge(clk);
			case expected_state is
				when 0 => 
					if A = '1' then
						expected_state := 1;
						expected_q := '0';
					else
						expected_state := 0;
						expected_q := '0';
					end if;
				when 1 => 
					if B = '1' then
						expected_state := 2;
						expected_q := '1';
						q_cover_cnt := q_cover_cnt + 1;
					else
						expected_state := 0;
						expected_q := '0';
					end if;
				when 2 =>
					expected_state := 0;
					expected_q := '0';
				when others =>
					expected_state := 0;
					expected_q := '0';
				end case;

				wait until falling_edge(clk);
				assert q = expected_q report "A: " & std_logic'image(A) &
				"B: " & std_logic'image(B) & "Q: " & std_logic'image(Q) &
				"expected_q: " & std_logic'image(expected_q);
				exit test_loop when (q_cover_cnt > 5);
				end loop;
				wait;
	end process stimulus;
end TB;

