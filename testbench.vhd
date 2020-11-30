library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity testbench is
end;

architecture test of testbench is

component mips_processor
 port(
  clk, reset: in  STD_LOGIC
 );
end component;

signal clk, reset: STD_LOGIC;
signal out_instf, out_instD: STD_LOGIC_VECTOR(31 downto 0);

begin
 mips: mips_processor port map(clk, reset);

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