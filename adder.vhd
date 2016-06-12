library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is
	port (srcA, srcB : in std_logic_vector(7 downto 0);
		result : out std_logic_vector(7 downto 0));

end Adder;


architecture Adder of Adder is 

begin

	result <= std_logic_vector(to_unsigned(to_integer
			(unsigned(srcA)) 
			+ to_integer(unsigned(srcB)),
			8)) ;

end Adder;


