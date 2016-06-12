library ieee;
use ieee.std_logic_1164.all;


entity AluControl is
	port(aluOp : in std_logic_vector(1 downto 0);
		funct : in std_logic_vector(5 downto 0);
		aluIn : out std_logic_vector(2 downto 0));
end AluControl;

architecture AluControl of AluControl is 
begin

	aluIn(0) <= '1' when (aluOp = "10" and funct = "100101") or (aluOp = "10" and funct = "101010") else
			'0' ;
	aluIn(1) <= '0' when aluOp = "10" and (funct = "100100" or funct = "100101") else
			'1' ;
	aluIn(2) <= '1' when (aluOp = "01" and funct = "100000") or (aluOp = "10" and (funct = "100010" or funct = "101010")) else
		'0' ;
end AluControl;

