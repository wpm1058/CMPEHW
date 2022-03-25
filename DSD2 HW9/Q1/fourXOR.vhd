--------------------------------------------------------------------------------
--
-- Title    : fourXOR.vhd
-- Project  : HW9
-- Author   : Walter Miller
-- Date     : 3/24/2022
--------------------------------------------------------------------------------
--
-- Description
-- 
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fourXor is
	port (
				a : in std_logic_vector(3 downto 0);
				y : out std_logic
			);	
end entity fourXor;

architecture dataMem of fourXOR is

begin
	y <= a(0) xor a(1) xor a(2) xor a(3);
end architecture dataMem;
