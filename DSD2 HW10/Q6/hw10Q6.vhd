library ieee;
use ieee.std_logic_1164.all;

entity hw10Q6 is
	port (
		clk,rst,ta,tb : in std_logic;
		la, lb : out std_logic_vector(1 downto 0)
	);
end hw10Q6;

architecture oh_behave of hw10Q6 is
	type state_type is (s0,s1,s2,s3);
	signal state, next_state : state_type;
	constant green : std_logic_vector(1 downto 0) := "00";
	constant yellow : std_logic_vector(1 downto 0) := "01";
	constant red : std_logic_vector(1 downto 0) := "10";
begin
	sync_proc: process(clk) is begin
		if rising_edge(clk) then
			if rst = '1' then
				state <= s0;
			else
				state <= next_state;
			end if;
		end if;
	end process;

	decode_proc : process (ta,tb,state) is begin
	  	case state is 
	  		when s0 => 
	  			if ta = '0' then
	  				next_state <= s1;
  				else
  					next_state <= s0;
				end if;
			when s1 => 
				next_state <= s2;
			when s2 =>
				if tb = '0' then 
					next_state <= s3;
				else
					next_state <= s2;
				end if;
			when s3 =>
				next_state <= s0;
		end case;
	end process decode_proc;

	la_proc : process (clk) is begin
	  	if rising_edge(clk) then
	 		case next_state is 
	 			when s0 => la <= green;
	 			when s1 => la <= yellow;
	 			when s2 | s3 => la <= red;
 			end case;
		end if;
	end process la_proc;

	lb_proc : process (clk) is begin
	  	if rising_edge(clk) then
	  		case (next_state) is
	  			when s0 | s1 => lb <= red;
	  			when s2 => lb <= green;
	  			when s3 => lb <= yellow;
	  		end case;
	  	end if;
	end process lb_proc;
	
end architecture oh_behave;