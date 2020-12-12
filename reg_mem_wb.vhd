--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Register file between MEM/WB phases

entity reg_mem_wb is
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
end;

architecture Behavioral of reg_mem_wb is
begin
 process(clk, reset) begin
  -- Reset: clear all signals
  if (reset = '1') then
      wb_regwrite <= '0';
      wb_memtoreg <= '0';
      wb_aluout <= (others => '0');
      wb_readdata <= (others => '0');
      wb_writereg <= (others => '0');
  -- Advance on clock cycle
  elsif rising_edge(clk) then
      wb_regwrite <= mem_regwrite;
      wb_memtoreg <= mem_memtoreg;
      wb_aluout <= mem_aluout;
      wb_readdata <= mem_readdata;
      wb_writereg <= mem_writereg;
  end if;
 end process;
end Behavioral;