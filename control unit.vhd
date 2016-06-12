library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
	port (opCode : in std_logic_vector(5 downto 0);
		branch : out std_logic;
		aluOP : out std_logic_vector(1 downto 0);
		aluSrc : out std_logic;
		regWrite : out std_logic;
		regDst : out std_logic;
		memRead : out std_logic;
		memWrite : out std_logic;
		memToReg : out std_logic);
end ControlUnit;

architecture ControlUnit of ControlUnit is
begin

		regDst <= '1' when opCode = "000000" else --R-typr
			'0' when opCode = "100011" else --lw
			 'X';   --sw, beq

		aluSrc <= '0' when opCode = "000000" or opCode = "000100" else
			'1';

		memtoReg <= '0' when opCode = "000000" else
			'1' when opCode = "100011" else
			'X';

		regWrite <= '1' when opCode = "000000" or opCode = "100011" else
			'0';

		memRead <= '1' when opCode = "100011" else
			 '0';

		memWrite <= '1' when opCode = "101011" else
			 '0';

		branch  <= '1' when opCode = "000100" else 
			'0';

		aluOP <= "10" when opCode = "000000" else
			"00" when opCode = "100011" or opCode = "101011" else
			 "01" when opCode = "000100";
	
end ControlUnit;
