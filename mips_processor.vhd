library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all; 

entity mips_processor is
 port
 (
  clk, reset: in  STD_LOGIC
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

 component dmem
  port(
	address: in std_logic_Vector(31 downto 0);
	writeData: in std_logic_Vector(31 downto 0);
	memRead:in std_logic;
	memWrite:in std_logic;
	readData: out std_logic_Vector(31 downto 0)   
  );
 end component;

 component RegisterFile
 Port
 (
        clk       : in  std_logic;
	readReg1  : in  std_logic_vector (4 downto 0);					--create a 6 bit read Register
	readReg2  : in  std_logic_vector (4 downto 0);					--create a second 6 bit read register0
	writeReg  : in  std_logic_vector (4 downto 0);					--create a 6 bit write register
	writeData : in  std_logic_vector (31 downto 0);					--create a 32 bit write data register
	regWrite  : in  std_logic;										--create a 1 bit register Write
	readData1 : out std_logic_vector (31 downto 0);					--create a 32 bit read data register
	readData2 : out std_logic_vector (31 downto 0)					--create a second 32 bit read data register
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

 component ALU
 port(
	in1, in2: in std_logic_vector(15 downto 0);
	control:  in std_logic_vector(2 downto 0);
	output:   out std_logic_vector(15 downto 0);
	zero:     out std_logic
 );
 end component;

 component ALU_Controller
 port(
	Operator: in  std_logic_vector(1 downto 0);
 	ALUFn:    in  std_logic_vector(2 downto 0);
	Control:  out std_logic_vector(2 downto 0)
 );
 end component;

 component dataforwarding
   port(regaddr:              in  STD_LOGIC_VECTOR(4 downto 0);
        writeRegM, writeRegW: in  STD_LOGIC_VECTOR(4 downto 0);
        regWriteM, regWriteW: in  STD_LOGIC;
        forward:              out STD_LOGIC_VECTOR(1 downto 0));
 end component;

 component controlforwarding
   port(regaddr:   in  STD_LOGIC_VECTOR(4 downto 0);
        writeRegM: in  STD_LOGIC_VECTOR(4 downto 0);
        regWriteM: in  STD_LOGIC;
        forward:   out STD_LOGIC);
 end component;

 component hardwarestall
   port(rsD, rtE, rtD: in  STD_LOGIC_VECTOR(4 downto 0);
        memToRegE:     in  STD_LOGIC;
        stall:         out STD_LOGIC);
 end component;

 component branchstall
   port(rsD, rtD:             in  STD_LOGIC_VECTOR(4 downto 0);
         branchD:              in  STD_LOGIC;
         regwriteE:            in  STD_LOGIC;
         writeregE, writeregM: in  STD_LOGIC_VECTOR(4 downto 0);
         memToRegM:            in  STD_LOGIC;
         stall:                out STD_LOGIC);
 end component;

 component reg_if_id
  port
  (
   clk, reset:      in  STD_LOGIC;
   pcplus4F, instF: in  STD_LOGIC_VECTOR(31 downto 0);
   pcplus4D, instD: out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component reg_ex_mem
  port
  (
   clk, reset:      in  STD_LOGIC;
   ex_regwrite, ex_memtoreg, ex_memwrite: in  STD_LOGIC;
   ex_writereg:             in  STD_LOGIC_VECTOR(4  downto 0);
   ex_aluout, ex_writedata: in  STD_LOGIC_VECTOR(31 downto 0);
   mem_regwrite, mem_memtoreg, mem_memwrite: out STD_LOGIC;
   mem_writereg:            out STD_LOGIC_VECTOR(4  downto 0);
   mem_aluout, mem_writedata: out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component reg_mem_wb
  port
  (
   clk, reset:      in  STD_LOGIC;
   mem_regwrite, mem_memtoreg: in  STD_LOGIC;
   mem_writereg:               in  STD_LOGIC_VECTOR(4  downto 0);
   mem_aluout, mem_readdata:   in  STD_LOGIC_VECTOR(31 downto 0);
   wb_regwrite, wb_memtoreg:   out STD_LOGIC;
   wb_writereg:                out STD_LOGIC_VECTOR(4  downto 0);
   wb_aluout, wb_readdata:     out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component; 


 signal pc, pcplus4F, instF, pcplus4D, instD, signimmD, immsh, pcbranch, pcnextbr, pcjump, pcnext: STD_LOGIC_VECTOR(31 downto 0);
 signal aluop: STD_LOGIC_VECTOR (1 downto 0);
 signal pcsrc: STD_LOGIC;
 signal regdst, jump, branchD, memread, memtoreg, memwrite, alusrc, regwrite: STD_LOGIC;
 signal resultW, rd1D, rd2D: STD_LOGIC_VECTOR (31 downto 0);
 signal rsD, rtD: STD_LOGIC_VECTOR(4 downto 0);
 signal rsE, rtE: STD_LOGIC_VECTOR(4 downto 0);
 signal forwardAD, forwardBD: STD_LOGIC;
 signal forwardAE, forwardBE: STD_LOGIC_VECTOR(1 downto 0);
 signal lwstall, brstall: STD_LOGIC;

-- dmem
 signal dmemaddr: STD_LOGIC_VECTOR(31 downto 0);
 signal writeData: STD_LOGIC_VECTOR(31 downto 0);
 signal dmemRead, dmemWrite: STD_LOGIC;
 signal readdata: STD_LOGIC_VECTOR(31 downto 0);
-- EX
 signal regwriteE, memtoregE, memwriteE: STD_LOGIC;
 signal writeregE: STD_LOGIC_VECTOR(4  downto 0);
 signal aluoutE, writedataE: STD_LOGIC_VECTOR(31 downto 0);
-- MEM
 signal regwriteM, memtoregM, memwriteM: STD_LOGIC;
 signal writeregM: STD_LOGIC_VECTOR(4  downto 0);
 signal aluoutM, writedataM: STD_LOGIC_VECTOR(31 downto 0);
-- WB
 signal regwriteW, memtoregW: STD_LOGIC;
 signal writeregW: STD_LOGIC_VECTOR(4  downto 0);
 signal aluoutW, readdataW: STD_LOGIC_VECTOR(31 downto 0);

begin
 pcjump <= pcplus4D(31 downto 28) & instD(25 downto 0) & "00";
 -- Instruction memory
 imem1:  imem      port map(pc, instF);
 -- Data Memory
 dmem1:  dmem      port map(dmemaddr, writeData, dmemRead, dmemWrite, readdata);
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
 -- Register File
 rf:     RegisterFile port map(clk, instD(25 downto 21), instD(20 downto 16), writeregW, resultW, regwriteW, rd1D, rd2D);
 -- Controller
 cntrl:  controller port map(instD(31 downto 26), regdst, jump, branchD, memread, memtoreg, aluop, memwrite, alusrc, regwrite);
 -- Data Forwarding
 forwardingAE: dataforwarding port map(rsE, writeRegM, writeRegW, regWriteM, regWriteW, forwardAE);
 forwardingBE: dataforwarding port map(rtE, writeRegM, writeRegW, regWriteM, regWriteW, forwardBE);
 -- Control Forwarding
 forwardingAD: controlforwarding port map (rsD, writeRegM, regWriteM, forwardAD);
 forwardingBD: controlforwarding port map (rtD, writeRegM, regWriteM, forwardBD);
 -- Hardware Stall
 hardwarestalling: hardwarestall port map (rsD, rtE, rtD, memToRegE, lwstall);
 -- Branch Stall
 branchstalling:   branchstall port map (rsD, rtD, branchD, regWriteE, writeRegE, writeRegM, memToRegM, brstall);
 -- IF/ID Register
 rIFID:  reg_if_id port map(clk, reset, pcplus4F, instF, pcplus4D, instD);
 -- ID/EX Register
 -- EX/MEM Register
 rEXMEM: reg_ex_mem port map(clk, reset, 
                             regwriteE, memtoregE, memwriteE, writeregE, aluoutE, writedataE,
                             regwriteM, memtoregM, memwriteM, writeregM, aluoutM, writedataM); 
 -- MEM/WB Register
 rMEMWB: reg_mem_wb port map(clk, reset,
                             regwriteM, memtoregM, writeregM, aluoutM, readdata,
                             regwriteW, memtoregW, writeregW, aluoutW, readdataW);

end;