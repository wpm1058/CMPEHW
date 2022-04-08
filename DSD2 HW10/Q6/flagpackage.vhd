library ieee;
use ieee.std_logic_1164.all;

package flagpackage is
	type flags is protected
		impure function GetLa return boolean;
		procedure en_la (la_enable : boolean);
		impure function GetLb return boolean;
		procedure en_lb (lb_enable : boolean);
	end protected flags;	
end package flagpackage;

package body flagpackage is
	type flags is protected body
		variable la_advance, lb_advance : boolean;

		impure function GetLa return boolean is
		begin
			return la_advance;
		end function GetLa;

		procedure en_la (la_enable : boolean) is
		begin
			la_advance := la_enable;
		end procedure en_la;

		impure function GetLb return boolean is
		begin
			return lb_advance;
		end function GetLb;

		procedure en_lb (lb_enable : boolean) is
		begin
			lb_advance := lb_enable;
		end procedure en_lb;
	end protected body flags;
end package body flagpackage;
