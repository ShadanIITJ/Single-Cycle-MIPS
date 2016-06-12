library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is
port(clk : in std_logic);
end CPU;


architecture CPU of CPU is

component PC
    Port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component Adder
	port (srcA : in std_logic_vector(7 downto 0);
		srcB : in std_logic_vector(7 downto 0);
		result : out std_logic_vector(7 downto 0));
end component;

component Alu
	port (srcA, srcB : in std_logic_vector(31 downto 0);
		aluOP : in std_logic_vector(2 downto 0);
		result : out std_logic_vector(31 downto 0);
		zero : out std_logic);
end component;

component AluControl is
	port(aluOp : in std_logic_vector(1 downto 0);
		funct : in std_logic_vector(5 downto 0);
		aluIn : out std_logic_vector(2 downto 0));
end component;

component ControlUnit
	port (opCode : in std_logic_vector(5 downto 0);
		branch : out std_logic;
		aluOP : out std_logic_vector(1 downto 0);
		aluSrc : out std_logic;
		regWrite : out std_logic;
		regDst : out std_logic;
		memRead : out std_logic;
		memWrite : out std_logic;
		memToReg : out std_logic);
end component;

component DataMem
    Port ( address : in  std_logic_vector (7 downto 0);
		dataIn : in std_logic_vector(31 downto 0);
		memWrite, memRead : in std_logic;
		clk : in std_logic;         
		dataOut : out  std_logic_vector (31 downto 0));
end component;

component InstMem
	Port ( address : in  std_logic_vector (7 downto 0);
		clk : in std_logic;         
		dataOut : out  std_logic_vector(31 downto 0));
end component;

component Mux
	port(srcA, srcB : in std_logic_vector(31 downto 0);
		sel : in std_logic;
		dataOut : out std_logic_vector(31 downto 0));
end component;

component Mux5
	port(srcA, srcB : in std_logic_vector(4 downto 0);
		sel : in std_logic;
		dataOut : out std_logic_vector(4 downto 0));
end component;

component Mux8
	port(srcA, srcB : in std_logic_vector(7 downto 0);
		sel : in std_logic;
		dataOut : out std_logic_vector(7 downto 0));
end component;


component RegFile
	port(regA, regB, regC : in std_logic_vector(4 downto 0);
		writeData : in std_logic_vector(31 downto 0);
		regWrite, clk : in std_logic;
		dataOutA, dataOutB: out std_logic_vector(31 downto 0));
end component;

signal nextPC : std_logic_vector(7 downto 0);
signal instAddr : std_logic_vector(7 downto 0);
signal nextAddr : std_logic_vector(7 downto 0):=(others=>'0');
signal brAddr : std_logic_vector(7 downto 0);

signal inst : std_logic_vector(31 downto 0);
signal branch : std_logic;
signal aluOP : std_logic_vector(1 downto 0);
signal aluSrc : std_logic;
signal regWrite : std_logic;
signal regDst : std_logic;
signal memRead : std_logic;
signal memWrite : std_logic;
signal memToReg : std_logic;

signal rtOrRd : std_logic_vector(4 downto 0);
signal writeData : std_logic_vector(31 downto 0);

signal readData1 : std_logic_vector(31 downto 0);
signal readData2 : std_logic_vector(31 downto 0);

signal aluIn : std_logic_vector(2 downto 0);

signal aluRes : std_logic_vector(31 downto 0);
signal zero : std_logic;
signal dataOut : std_logic_vector(31 downto 0);

--signal internalClk : std_logic;

signal aluData2 : std_logic_vector(31 downto 0);
signal ext : std_logic_vector(31 downto 0);

signal doBranch : std_logic;
begin

PCCOM: 	PC port map(nextAddr, clk, instAddr);
ADDCOM:	Adder port map(instAddr, std_logic_vector(to_unsigned(4,8)), nextPC);
BRADDER:Adder port map(nextPC, ext(7 downto 0), brAddr);
doBranch <= branch and zero;
MUXBR: Mux8 port map(nextPC, brAddr, doBranch, nextAddr);
INSTCOM:InstMem port map(instAddr, clk, inst);
CU: 	ControlUnit port map(inst(31 downto 26), branch, aluOP, aluSrc, regWrite, regDst, memRead, memWrite, memToReg);
MUXREG:	Mux5 port map(inst(20 downto 16), inst(15 downto 11), regDst, rtOrRd);
REGS:	RegFile port map(inst(25 downto 21), inst(20 downto 16), rtOrRd, writeData, regWrite, clk, readData1, readData2);
ALUCON:	AluControl port map(aluOp, inst(5 downto 0), aluIn);
ext <= X"0000"&inst(15 downto 0)when inst(15)='0' else
	X"FFFF"&inst(15 downto 0)when inst(15)='1';
MUXALU:	Mux port map(ext, readData2, aluSrc, aluData2);
ALUCOM: Alu port map(readData1, aluData2, aluIn, aluRes, zero);
DATACOM:DataMem port map(aluRes(7 downto 0), readData2, memWrite, memRead, clk, dataOut);
MUXMEM:	Mux port map(dataOut, aluRes, memToReg, writeData);

end CPU;

configuration CPUConf of CPU is
for CPU
	for PCCOM : PC use entity work.PC;end for;
	for ADDCOM : Adder use entity work.Adder;end for;
	for BRADDER: Adder use entity work.Adder;end for;
	for INSTCOM : InstMem use entity work.InstMem;end for;
	for CU : ControlUnit use entity work.ControlUnit;end for;
	for MUXREG : Mux5 use entity work.Mux5;end for;
	for REGS : RegFile use entity work.RegFile;end for;
	for ALUCON : AluControl use entity work.AluControl;end for;
	for ALUCOM : Alu use entity work.Alu;end for;
	for DATACOM : DataMem use entity work.DataMem;end for;
	for MUXALU : Mux use entity work.Mux;end for;
	for MUXMEM : Mux use entity work.Mux;end for;
	for MUXBR : Mux8 use entity work.Mux8;end for;
end for;
end CPUConf;