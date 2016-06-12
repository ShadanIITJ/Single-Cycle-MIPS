library ieee;
use ieee.std_logic_1164.ALL;

entity PC is
    Port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end PC;

architecture PC of PC is

begin

process(clk)
  begin
     if rising_edge(clk) then
       output <= input;
    end	if;  
  end process;
  
end PC;


