library ieee;
use ieee.std_logic_1164.all;

use ieee.std_logic_signed.all;

entity Alu is
	port (srcA, srcB : in std_logic_vector(31 downto 0);
		aluOP : in std_logic_vector(2 downto 0);
		result : out std_logic_vector(31 downto 0);
		zero : out std_logic);

end Alu;


architecture Alu of Alu is 

begin

	result <= srcA and srcB when aluOP = "000" else
		srcA or srcB when aluOP = "001" else
		srcA + srcB when aluOP =  "010" else
		srcA - srcB when aluOP = "110" else
		X"00000000" ;
	
	zero <= '1' when srcA = srcB else
		'0';
end Alu;


