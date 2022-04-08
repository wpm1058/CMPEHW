-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity hw10Q2TB is
end;

architecture bench of hw10Q2TB is

  component hw10Q2
  	port (
  		s,r : in std_logic;
  		q 	: out std_logic
  	);
  end component;

  signal s,r: std_logic;
  signal q: std_logic ;
  signal reset_covered, set_covered, hold_after_reset_covered, hold_after_set_covered : integer : = 0;

begin

  uut: hw10Q2 port map ( s => s,
                         r => r,
                         q => q );

  stimulus: process
    variable rand : real;
    variable seed1, seed2 : integer := 999;
    variable expected_q : std_logic;
  begin
  
    -- Put initialisation code here
      s <= '0'; r <= '1';
      wait for 10 ns;

      test_loop: loop
          uniform(see1, seed2, rand);
          if (rand < 0.33) then
            s <= '0'; r <= '1';
            reset_covered <= reset_covered+1;
            expected_q := '0';
          elsif (rand < 0.66) then
            s <= '1'; r <= '0';
            set_covered <= set_covered + 1;
            expected_q := '1';
          else
            s <= '0'; r <= '0';
            if (s = '0') and (r ='1') then
              hold_after_reset_covered <= hold_after_reset_covered + 1;
              expected_q := '0';
            elsif (s = '1') and (r = '0') then
              hold_after_set_covered <= hold_after_set_covered + 1;
              expected_q := '0';
            else
              expected_q := expected_q;
            end if;
          end if;
          wait for 10 ns;
          assert q = expected_q
            report "Error: s = " & std_logic'image(s) & " r = " & std_logic'image(r) & " q = " &
            std_logic'image(q) &
              " but expected_q = " & std_logic'image(expected_q);
            exit test_loop when (reset_covered > 1) and (set_covered > 1) and 
            (hold_after_set_covered > 1) and (hold_after_reset_covered > 1);
              wait for 10 ns;
            end loop;
            wait;
          end process;   
end;