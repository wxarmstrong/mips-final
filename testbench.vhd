--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity testbench is
end;

architecture test of testbench is

component mips_processor
    port(clk, reset:                      in  STD_LOGIC
    );
end component;
signal clk, reset: STD_LOGIC;

begin
 mips: mips_processor port map(clk, reset);

-- Drive the clock cycle
 process begin
  clk <= '0';
  wait for 5 ns;
  clk <= '1';
  wait for 5 ns;
 end process;

-- Begin with reset held for 2 clock cycles to clear signal values
 process begin
  reset <= '1';
  wait for 22 ns;
  reset <= '0';
  wait;
 end process;

end;