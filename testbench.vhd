library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity testbench is
end;

architecture test of testbench is

component mips_processor
    port(clk, reset:                      in  STD_LOGIC;
          ra1_out, ra2_out:               out STD_LOGIC_VECTOR(4 downto 0);
          rd1D_out, rd2D_out:             out STD_LOGIC_VECTOR(31 downto 0)
   --    pc_out, instrF_out, instrD_out: out    STD_LOGIC_VECTOR(31 downto 0);
   --    enableD_out, enableF_out:       out    STD_LOGIC;
   --    pcsrc_out, branch_out, jump_out: out    STD_LOGIC;
   --    pcnextbr_out, pcnext_out:       out    STD_LOGIC_VECTOR(31 downto 0);
--


   --    aluop_out:                      out    STD_LOGIC_VECTOR(1 downto 0);
   --    srcaE_out, srcbE_out:           out    STD_LOGIC_VECTOR(31 downto 0);
   --    aluoutE_out:                    out    STD_LOGIC_VECTOR(31 downto 0);
   --    readdata_out:                   out    STD_LOGIC_VECTOR(31 downto 0);
   --    resultW_out:                    out    STD_LOGIC_VECTOR(31 downto 0)
   --      writedata, dataadr:        out STD_LOGIC_VECTOR(31 downto 0);
   --      memwrite:                  out STD_LOGIC;
   --      memWriteMDep:              out STD_LOGIC
   --      dataadrMDep, writeDataMDep: out STD_LOGIC_VECTOR(31 downto 0)
 );
end component;

  signal clk, reset: STD_LOGIC;
  signal pc_out, instrF_out, instrD_out: STD_LOGIC_VECTOR(31 downto 0);
  signal enableD_out, enableF_out: STD_LOGIC;
  signal pcsrc_out, branch_out, jump_out:  STD_LOGIC;
  signal pcnextbr_out, pcnext_out: STD_LOGIC_VECTOR(31 downto 0);

  signal ra1_out, ra2_out:         STD_LOGIC_VECTOR(4 downto 0);

  signal rd1D_out, rd2D_out: STD_LOGIC_VECTOR(31 downto 0);
  signal aluop_out: STD_LOGIC_VECTOR(1 downto 0);
  signal srcaE_out, srcbE_out: STD_LOGIC_VECTOR(31 downto 0);
  signal aluoutE_out: STD_LOGIC_VECTOR(31 downto 0);
  signal readdata_out: STD_LOGIC_VECTOR(31 downto 0);
  signal resultW_out: STD_LOGIC_VECTOR(31 downto 0);
--  signal writedata, dataadr: STD_LOGIC_VECTOR(31 downto 0);
--  signal memwrite: STD_LOGIC;
--  signal memWriteMDep: STD_LOGIC;
--  signal dataadrMDep, writeDataMDep: STD_LOGIC_VECTOR(31 downto 0);

begin
 mips: mips_processor port map(clk, reset, 
                               ra1_out, ra2_out,
                               rd1D_out, rd2D_out);
--pc_out, instrF_out, instrD_out, 
--                               enableD_out, enableF_out, pcsrc_out, branch_out, 
--                               jump_out, pcnextbr_out, 
--                               ra1_out, ra2_out, 
--                               rd1D_out, rd2D_out,
--                               pcnext_out, aluop_out, 
--                               aluoutE_out, readdata_out, resultW_out);

 process begin
  clk <= '0';
  wait for 5 ns;
  clk <= '1';
  wait for 5 ns;
 end process;

 process begin
  reset <= '1';
  wait for 22 ns;
  reset <= '0';
  wait;
 end process;

end;