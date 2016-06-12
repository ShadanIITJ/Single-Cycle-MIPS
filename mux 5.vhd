
library ieee;
use ieee.std_logic_1164.all;

entity Mux5 is
port(srcA, srcB : in std_logic_vector(4 downto 0);
	sel : in std_logic;
	dataOut : out std_logic_vector(4 downto 0));
end Mux5;

architecture Mux5 of Mux5 is
begin
	dataOut <= srcA when sel = '0' else
			srcB;
end Mux5;
