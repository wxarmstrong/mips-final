--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

-- MIPS Processor

library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all; 

entity mips_processor is
  port(
       clk, reset:                     in     STD_LOGIC
      );
end;

architecture Behavioral of mips_processor is

-- COMPONENTS

 component adder
  port(
   a, b: in  STD_LOGIC_VECTOR(31 downto 0);
   c:    out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component compare
  port(
   a, b: in  STD_LOGIC_VECTOR(31 downto 0);
   eq:    out STD_LOGIC
  );
 end component;

 component mux2
 generic(width: integer);
  port(
   a, b: in  STD_LOGIC_VECTOR(width-1 downto 0);
   c:    in  STD_LOGIC;
   d:    out STD_LOGIC_VECTOR(width-1 downto 0)
  );
 end component;

 component mux3
 generic(width: integer);
  port(a, b, c: in  STD_LOGIC_VECTOR(width-1 downto 0);
       s:       in  STD_LOGIC_VECTOR(1 downto 0);
       y:       out STD_LOGIC_VECTOR(width-1 downto 0)
 );
 end component;

 component signext
  port(
   a: in  STD_LOGIC_VECTOR(15 downto 0);
   b: out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component unsignext
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
   clk, reset, enable: in  STD_LOGIC;
   d:                  in  STD_LOGIC_VECTOR(31 downto 0);
   q:                  out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component imem
  port(
   pc:   in  STD_LOGIC_VECTOR(31 downto 0);
   inst: out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component dmem
  port(clk, we:  in STD_LOGIC;
       a, wd:    in STD_LOGIC_VECTOR(31 downto 0);
       rd:       out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

 component RegisterFile
 Port
 (
       clk:           in  STD_LOGIC;
       we3:           in  STD_LOGIC;
       ra1, ra2, wa3: in  STD_LOGIC_VECTOR(4 downto 0);
       wd3:           in  STD_LOGIC_VECTOR(31 downto 0);
       rd1, rd2:      out STD_LOGIC_VECTOR(31 downto 0)
 );
 end component;

 component maindec
  port
  (
       op:                 in  STD_LOGIC_VECTOR(5 downto 0);
       memtoreg, memwrite: out STD_LOGIC;
       branch, alusrc:     out STD_LOGIC;
       regdst, regwrite:   out STD_LOGIC;
       jump:               out STD_LOGIC;
       aluop:              out STD_LOGIC_VECTOR(2 downto 0);
       zerosrc:            out STD_LOGIC;
       immsrc:             out STD_LOGIC
  );
 end component;

 component aludec
  port
  (
       funct:      in  STD_LOGIC_VECTOR(5 downto 0);
       aluop:      in  STD_LOGIC_VECTOR(2 downto 0);
       alucontrol: out STD_LOGIC_VECTOR(2 downto 0)
  );
 end component;

  component alu
    port(a, b:       in  STD_LOGIC_VECTOR(31 downto 0);
         alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
         shift:      in  STD_LOGIC_VECTOR(4 downto 0);
         result:     out STD_LOGIC_VECTOR(31 downto 0);
         zero:       out STD_LOGIC);
  end component;

  component hazardunit is
    port(rsE, rtE, rsD, rtD:              in  STD_LOGIC_VECTOR(4 downto 0);
         regWriteM, regWriteW, regWriteE: in  STD_LOGIC;
         writeRegM, writeRegW, writeRegE: in  STD_LOGIC_VECTOR(4 downto 0);
         memToRegE, memToRegM:            in  STD_LOGIC;
         branchD:                         in  STD_LOGIC;
         forwardAE, forwardBE:            out STD_LOGIC_VECTOR(1 downto 0);
         forwardAD, forwardBD:            out STD_LOGIC;
         stallF, stallD, flushE:          out STD_LOGIC);
  end component;

 component reg_if_id
  port
  (
   clk, enable, reset: in  STD_LOGIC;
   flush:              in  STD_LOGIC;
   pcplus4F, instrF:   in  STD_LOGIC_VECTOR(31 downto 0);
   pcplus4D, instrD:   out STD_LOGIC_VECTOR(31 downto 0)
  );
 end component;

  component reg_id_ex
    port(clk, reset:               in  STD_LOGIC;
         flush:                    in  STD_LOGIC;
         id_regwrite, id_memtoreg: in  STD_LOGIC;
         id_memwrite, id_alusrc:   in  STD_LOGIC;
         id_regdst, id_immsrc:     in  STD_LOGIC;
         id_alucontrol:            in  STD_LOGIC_VECTOR(2 downto 0);
         id_rd1, id_rd2:           in  STD_LOGIC_VECTOR(31 downto 0);
         id_signimm, id_unsignimm: in  STD_LOGIC_VECTOR(31 downto 0);
         id_rs, id_rt, id_rd:      in  STD_LOGIC_VECTOR(4  downto 0);
         id_shift:                 in  STD_LOGIC_VECTOR(4  downto 0);
         ex_regwrite, ex_memtoreg: out STD_LOGIC;
         ex_memwrite, ex_alusrc:   out STD_LOGIC;
         ex_regdst, ex_immsrc:     out STD_LOGIC;
         ex_alucontrol:            out STD_LOGIC_VECTOR(2 downto 0);
         ex_rd1, ex_rd2:           out STD_LOGIC_VECTOR(31 downto 0);
         ex_signimm, ex_unsignimm: out STD_LOGIC_VECTOR(31 downto 0);
         ex_rs, ex_rt, ex_rd:      out STD_LOGIC_VECTOR(4  downto 0);
         ex_shift:                 out STD_LOGIC_VECTOR(4  downto 0));
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

 -- PC path
 signal pc:                 STD_LOGIC_VECTOR(31 downto 0);
 signal pcplus4F:           STD_LOGIC_VECTOR(31 downto 0);
 signal instrF:             STD_LOGIC_VECTOR(31 downto 0);
 
 signal pcbranch:           STD_LOGIC_VECTOR(31 downto 0);
 signal pcsrc:              STD_LOGIC;

 signal pcnextbr, pcjump:   STD_LOGIC_VECTOR(31 downto 0);

 signal pcnext:             STD_LOGIC_VECTOR(31 downto 0);
 
 -- IF->
 signal enableF:            STD_LOGIC;

 -- ID->
 signal enableD:            STD_LOGIC;
 signal instrD, pcplus4D:   STD_LOGIC_VECTOR(31 downto 0);
 signal rsD, rtD:           STD_LOGIC_VECTOR(4  downto 0);

 signal signimmD, unsignimmD, immsh, imm: STD_LOGIC_VECTOR(31 downto 0);

 -- EX->
 signal rsE, rtE, rdE, writeregE:  STD_LOGIC_VECTOR(4  downto 0);
 signal regwriteE, memtoregE, memwriteE, alusrcE, regdstE, immsrcE: STD_LOGIC;
 signal rd1E, rd2E, signimmE, unsignimmE: STD_LOGIC_VECTOR(31 downto 0);
 signal alucontrolE:          STD_LOGIC_VECTOR(2  downto 0);
 signal shiftE:               STD_LOGIC_VECTOR(4  downto 0);

 -- MEM->
 signal regwriteM, memtoregM, memwriteM: STD_LOGIC;
 signal aluoutM, writedataM: STD_LOGIC_VECTOR(31 downto 0);
 signal writeregM:           STD_LOGIC_VECTOR(4 downto 0);

 -- WB->
 signal regwriteW, memtoregW: STD_LOGIC;
 signal aluoutW, readdataW: STD_LOGIC_VECTOR(31 downto 0);
 signal writeregW:          STD_LOGIC_VECTOR(4 downto 0);
 
 -- writedatamux
 signal writedataE:         STD_LOGIC_VECTOR(31 downto 0);

 -- resmux
 signal resultW:            STD_LOGIC_VECTOR(31 downto 0);

 -- Controller
 --- maindec
 signal memtoreg, memwrite, branchD, alusrc,
        regdst, regwrite, jump, zerosrc, immsrc: STD_LOGIC;
 signal aluop:              STD_LOGIC_VECTOR(2 downto 0); 
 --- aludec
 signal alucontrol:         STD_LOGIC_VECTOR(2 downto 0);
 -- regfile
 signal rd1D, rd2D:         STD_LOGIC_VECTOR(31 downto 0);
 -- dmem
 signal readdata:                  STD_LOGIC_VECTOR(31 downto 0);

 -- ALU
 signal srcaE, srcbE:       STD_LOGIC_VECTOR(31 downto 0);
 signal aluoutE:            STD_LOGIC_VECTOR(31 downto 0);

 -- Comparator
 signal operand1, operand2: STD_LOGIC_VECTOR(31 downto 0);
 signal zero:               STD_LOGIC;
 -- Assorted sources
 signal mux_zero:           STD_LOGIC;
 -- Forward
 signal forwardAE, forwardBE: STD_LOGIC_VECTOR(1 downto 0);
 signal forwardAD, forwardBD: STD_LOGIC;
 -- Stalls
 signal stallF, stallD, flushE: STD_LOGIC;

begin

 -- ID and IF phases should only advance if a stall is not detected
 enableD <= not(stallD);
 enableF <= not(stallF);

 rsD <= instrD(25 downto 21);
 rtD <= instrD(20 downto 16);
 pcjump <= pcplus4D(31 downto 28) & instrD(25 downto 0) & "00";

 -- For a BNE operation, swap the result of the comparison
 mux_zero <= zero when zerosrc = '0' else not zero;
 
 -- Indicates if a branch is taken
 pcsrc <= mux_zero and branchD;

 -- Instruction memory
 instrMEM:  imem      port map(pc, instrF);
 -- Data Memory
 dataMEM:  dmem      port map(clk, memwriteM, aluoutM, writedataM, readdata);

 -- Adds 4 to the PC value to advance to the adjacent instruction
 adder1:  adder     port map(pc, x"00000004", pcplus4F);

 -- Adds the offset value to the PC to determine the PC branch destination
 adder2:  adder     port map(pcplus4D, immsh, pcbranch);

 -- Compare (for BEQ/BNE)
 comparator:   compare   port map(operand1, operand2, zero);

 -- Sign Extend
 sign_ex:  signext   port map(instrD(15 downto 0), signimmD);
 -- Unsign Extend
 unsign_ex: unsignext port map(instrD(15 downto 0), unsignimmD); 

 -- This shifts the offset value for branch instructions so that the # of instructions indicated
 --  is shifted to match the exact instruction address offset (i.e. multiplied by 4)
 shftl2:  sl2       port map(signimmD, immsh);

 -- 2-Way Multiplexers
 mux2a:       mux2 generic map(32) port map(pcplus4F, pcbranch, pcsrc, pcnextbr); -- Use branch destination if branch occurs
 mux2b:       mux2 generic map(32) port map(pcnextbr, pcjump, jump, pcnext);      -- Use jump destination if jump occurs

 -- Reads the operands for the ALU directly from the previous phrase in case of forwarding
 forward1_mux: mux2 generic map(32) port map(rd1D, aluoutM, forwardAD, operand1);
 forward2_mux: mux2 generic map(32) port map(rd2D, aluoutM, forwardBD, operand2);

 -- Determines which register value to use for the writereg
 writereg_mux:       mux2 generic map(5)  port map(rtE, rdE, regdstE, writeregE);

 -- Determines whether to use ALU value or dmem value
 result_mux:      mux2 generic map(32) port map(aluoutW, readdataW,  memtoregW, resultW);


 -- This multiplexer controls whether or not to use a signed or unsigned immediate value
 immediate_mux:       mux2 generic map(32) port map(signimmE, unsignimmE, immsrcE, imm);

 -- This multiplexer controls whether to use an immediate value or another value
 --  for the 2nd operand of the ALU.
 sourceb_mux:     mux2 generic map(32) port map(writedataE, imm, alusrcE, srcbE);

 -- 3-Way Multiplexers

 -- This multiplexer controls the source of the first operand to the ALU. If forwarding is present,
 --  the value sent will be from the ALU of the previous MEM phase or from the previous WB phase.
 sourcea_mux:      mux3 generic map(32) port map(rd1E, resultW, aluoutM, forwardAE, srcaE);

 -- This multiplexer controls the source of the 2nd operand to the ALU. If forwarding is present,
 --  the value sent will be from the ALU of the previous MEM phase or from the previous WB phase.
 wdata_mux: mux3 generic map(32) port map(rd2E, resultW, aluoutM, forwardBE, writedataE);

 -- Flip-Flop
 flopper:  flopr     port map(clk, reset, enableF, pcnext, pc);

 -- Register File
 regfile:     RegisterFile port map(clk, regwriteW, instrD(25 downto 21), instrD(20 downto 16), writeregW, resultW, rd1D, rd2D);

 -- Controller
 maind: maindec port map(instrD(31 downto 26), memtoreg, memwrite, branchD, alusrc, regdst, regwrite, jump, aluop, zerosrc, immsrc);
 alud: aludec  port map(instrD(5 downto 0), aluop, alucontrol);

 -- ALU
 alu1: alu port map(srcaE, srcbE, alucontrolE, shiftE, aluoutE, open);

 -- Hazard Unit
 hazard: hazardunit port map(rsE, rtE, rsD, rtD, regwriteM, regwriteW, regwriteE,
                         writeregM, writeregW, writeregE, memtoregE, memtoregM,
                         branchD, forwardAE, forwardBE, forwardAD, forwardBD,
                         stallF, stallD, flushE);

 -- IF/ID Register
 rIFID:  reg_if_id port map(clk, enableD, reset, pcsrc, pcplus4F, instrF, pcplus4D, instrD);
 -- ID/EX Register
 rIDEX:  reg_id_ex port map(clk, reset, flushE, regwrite, memtoreg, memwrite,
                            alusrc, regdst, immsrc, alucontrol,
                            rd1D, rd2D, signimmD, unsignimmD,
                            instrD(25 downto 21), instrD(20 downto 16), instrD(15 downto 11), instrD(10 downto 6),
                            regwriteE, memtoregE, memwriteE,
                            alusrcE, regdstE, immsrcE, alucontrolE,
                            rd1E, rd2E, signimmE, unsignimmE,
                            rsE, rtE, rdE, shiftE);
 -- EX/MEM Register
 rEXMEM: reg_ex_mem port map(clk, reset, 
                             regwriteE, memtoregE, memwriteE, writeregE, aluoutE, writedataE,
                             regwriteM, memtoregM, memwriteM, writeregM, aluoutM, writedataM); 
 -- MEM/WB Register
 rMEMWB: reg_mem_wb port map(clk, reset,
                             regwriteM, memtoregM, writeregM, aluoutM, readdata,
                             regwriteW, memtoregW, writeregW, aluoutW, readdataW);

end;