library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity flopr is
 port(
  clk, reset: in  STD_LOGIC;
  a:          in  STD_LOGIC_VECTOR(31 downto 0);
  b:          out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of flopr is
begin
 process(clk, reset) begin
  if (reset = '1') then b <= (others => '0');
  elsif rising_edge(clk) then
   b <= a;
  end if;
 end process;
end;