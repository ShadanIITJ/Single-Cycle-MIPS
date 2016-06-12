library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity InstMem is
    Port ( address : in  std_logic_vector (7 downto 0);
		clk : in std_logic;         
		dataOut : out  std_logic_vector(31 downto 0));
end InstMem;


architecture InstMem of InstMem is

type mem_255x32 is array (0 to 255) of std_logic_vector(7 downto 0);
signal memContent: mem_255x32 ;
begin
	process (address)
	begin
		if clk='1' then
			--if memWrite = '0' then
				dataOut(31 downto 24) <= memContent(to_integer(unsigned(address)));
				dataOut(23 downto 16) <= memContent(to_integer(unsigned(address))+1);
				dataOut(15 downto 8) <= memContent(to_integer(unsigned(address))+2);
				dataOut(7 downto 0) <= memContent(to_integer(unsigned(address))+3);
			
			--else
			--	memContent(to_integer(unsigned(address))) <= dataIn;
			--end if;
		end if;

	end process;	

end InstMem;

