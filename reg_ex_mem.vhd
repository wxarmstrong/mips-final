library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reg_ex_mem is
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
end;

architecture Behavioral of reg_ex_mem is
begin
 process(clk, reset) begin
  if (reset = '1') then
      mem_regwrite <= '0';
      mem_memtoreg <= '0';
      mem_memwrite <= '0';
      mem_aluout <= (others => '0');
      mem_writereg <= (others => '0');
      mem_writedata <= (others => '0');
  elsif rising_edge(clk) then
      mem_regwrite <= ex_regwrite;
      mem_memtoreg <= ex_memtoreg;
      mem_memwrite <= ex_memwrite;
      mem_aluout <= ex_aluout;
      mem_writereg <= ex_writereg;
      mem_writedata <= ex_writedata;
  end if;
 end process;
end Behavioral;



