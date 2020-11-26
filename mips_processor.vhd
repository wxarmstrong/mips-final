library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all; 

entity mips_processor is
 port
 (
  clk, reset: in  STD_LOGIC;
  out_instf:  out STD_LOGIC_VECTOR(31 downto 0);
  out_instd:  out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of mips_processor is

 component adder
  port(
   a, b: in  STD_LOGIC_VECTOR(31 downto 0);
   c:    out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component mux2
  port(
   a, b: in  STD_LOGIC_VECTOR(31 downto 0);
   c:    in  STD_LOGIC;
   d:    out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component signext
  port(
   a: in  STD_LOGIC_VECTOR(15 downto 0);
   b: out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component sl2
  port(
   a: in  STD_LOGIC_VECTOR(31 downto 0);
   b: out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component flopr
  port(
   clk, reset: in  STD_LOGIC;
   a:          in  STD_LOGIC_VECTOR(31 downto 0);
   b:          out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component imem
  port(
   pc:   in  STD_LOGIC_VECTOR(31 downto 0);
   inst: out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component controller
  port
  (
	opcode: in STD_LOGIC_VECTOR(5 downto 0);
	regdst: out STD_LOGIC;
	jump: out STD_LOGIC;
	branch: out STD_LOGIC;
	memread: out STD_LOGIC;
	memtoreg: out STD_LOGIC;
	aluop: out STD_LOGIC_VECTOR (1 downto 0);
	memwrite: out STD_LOGIC;
	alusrc: out STD_LOGIC;
	regwrite: out STD_LOGIC
  );
 end component;

 component reg_if_id
  port
  (
   clk, reset:      in  STD_LOGIC;
   pcplus4F, instF: in  STD_LOGIC_VECTOR(31 downto 0);
   pcplus4D, instD: out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 signal pc, pcplus4F, instF, pcplus4D, instD, signimmD, immsh, pcbranch, pcnextbr, pcjump, pcnext: STD_LOGIC_VECTOR(31 downto 0);
 signal aluop: STD_LOGIC_VECTOR (1 downto 0);
 signal pcsrc: STD_LOGIC;
 signal regdst, jump, branch, memread, memtoreg, memwrite, alusrc, regwrite: STD_LOGIC;
begin
 out_instf <= instF;
 out_instD <= instD;
 pcjump <= pcplus4D(31 downto 28) & instD(25 downto 0) & "00";
 -- Instruction memory
 imem1:  imem      port map(pc, instF);
 -- PC Adder (+4)
 addr1:  adder     port map(pc, x"00000004", pcplus4F);
 addr2:  adder     port map(pcplus4D, immsh, pcbranch);
 -- Sign Extend
 signx:  signext   port map(instD(15 downto 0), signimmD);
 -- Shift Left 2
 shftl:  sl2       port map(signimmD, immsh);
 -- Multiplices
 mux2a:  mux2      port map(pcplus4F, pcbranch, pcsrc, pcnextbr);
 mux2b:  mux2      port map(pcnextbr, pcjump, jump, pcnext);
 -- Flip-Flop
 flop1:  flopr     port map(clk, reset, pcnext, pc);
 -- Controller
 cntrl:  controller port map(instF(31 downto 26), regdst, jump, branch, memread, memtoreg, aluop, memwrite, alusrc, regwrite);
 -- IF/ID Register
 rIFID:  reg_if_id port map(clk, reset, pcplus4F, instF, pcplus4D, instD);

end;