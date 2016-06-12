
library ieee;
use ieee.std_logic_1164.all;

entity Mux is
port(srcA, srcB : in std_logic_vector(31 downto 0);
	sel : in std_logic;
	dataOut : out std_logic_vector(31 downto 0));
end Mux;

architecture Mux of Mux is
begin
	dataOut <= srcA when sel = '1' else
			srcB;
end Mux;
