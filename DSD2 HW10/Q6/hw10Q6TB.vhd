library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.flagpackage.all;

entity hw10Q6TB is
end hw10Q6TB;

architecture hw10Q6TB_arc of hw10Q6TB is
	signal clk,rst,ta,tb : std_logic := '0';
	signal la,lb: std_logic_vector(1 downto 0);
	constant clock_period: time := 10 ns;

	signal ExpectedLa, ExpectedLb : std_logic_vector(1 downto 0);
	signal la_red_cnt la_grn_cnt : integer := 0;
	signal lb_red_cnt lb_grn_cnt : integer := 0;
	shared variable fsm_adv : flags;

	constant green : std_logic_vector(1 downto 0) := "00";
	constant yellow : std_logic_vector(1 downto 0) := "01";
	constant red : std_logic_vector(1 downto 0) := "10";
	constant invalid_clr : std_logic_vector(1 downto 0) := "11";

	component hw10Q6
  	port (
  		clk,rst,ta,tb : in std_logic;
  		la, lb : out std_logic_vector(1 downto 0)
  	);
  end component;
begin

  uut: hw10Q6 port map ( clk => clk,
                         rst => rst,
                         ta  => ta,
                         tb  => tb,
                         la  => la,
                         lb  => lb );

  stimulus: process

  	variable rand : real;
  	variable seed1,seed2 : integer := 999;
  	begin
  		rst <= '1';
  		wait for clock_period;
  		wait until clk = '0';
  		rst <= '0';

  		test_loop : loop
  			uniform(seed1, seed2, rand);
  			if (rand < 0.25) then
  				ta <= '0'; tb <= '0';
  				fsm_adv.en_la(true); fsm_adv.en_lb(true);
			elsif (rand < 0.5) then
  				ta <= '0'; tb <= '1';
  				fsm_adv.en_la(true); fsm_adv.en_lb(false);
			elsif (rand < 0.75) then
  				ta <= '1'; tb <= '0';
  				fsm_adv.en_la(false); fsm_adv.en_lb(true);
			else
  				ta <= '1'; tb <= '1';
  				fsm_adv.en_la(false); fsm_adv.en_lb(false);	
  			end if;
  			wait for clock_period;
  			assert (la = ExpectedLa) and (lb = ExpectedLb) 
  			report "error, not correct state";
  			exit test_loop when la_grn_cnt > 1 and la_red_cnt > 1 and lb_grn_cnt > 1 and lb_red_cnt > 1;
  			wait for 10 ns;
  		end loop;
  		wait;
  end process;

  state_mach_sim: process
  begin
    wait until clk = '1'
    if rst = '1' then
    	ExpectedLa <= green; 
    	ExpectedLb <= red;
    else
    	case(ExpectedLa & ExpectedLb) is
    		when green & red => 
    			if fsm_adv.GetLa then
    				ExpectedLa <= yellow; 
    				ExpectedLb <= red;
    				la_grn_cnt <= la_grn_cnt + 1;
				end if;		
    		when yellow & red => 
    			ExpectedLa <= red; 
    			ExpectedLb <= green;
    			lb_red_cnt <= lb_red_cnt + 1;
			when red & green => 
    			if fsm_adv.GetLb then
    				ExpectedLa <= red; 
    				ExpectedLb <= yellow;
    				lb_grn_cnt <= lb_grn_cnt + 1;
				end if;
			when red & yellow => 
    			ExpectedLa <= green; 
    			ExpectedLb <= red;
    			la_red_cnt <= la_red_cnt + 1;
			when other =>
				ExpectedLa <= invalid_clr; 
				ExpectedLb <= invalid_clr;
    	end case;
	end if;
  end process;
end hw10Q6TB_arc;