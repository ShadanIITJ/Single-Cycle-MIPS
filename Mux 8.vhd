
library ieee;
use ieee.std_logic_1164.all;

entity Mux8 is
port(srcA, srcB : in std_logic_vector(7 downto 0);
	sel : in std_logic;
	dataOut : out std_logic_vector(7 downto 0));
end Mux8;

architecture Mux8 of Mux8 is
begin
	dataOut <= srcA when sel = '0' else
			srcB;
end Mux8;
