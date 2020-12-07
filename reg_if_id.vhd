library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reg_if_id is
 port
 (
  clk, enable, reset: in  STD_LOGIC;
  flush:              in  STD_LOGIC;
  pcplus4F, instrF:   in  STD_LOGIC_VECTOR(31 downto 0);
  pcplus4D, instrD:   out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of reg_if_id is
begin
 process(clk)
 begin
  if (reset = '1') then
   instrD   <= x"00000000";
   pcplus4D <= x"00000000";
  elsif rising_edge(clk) then
   if (enable = '1' and flush = '1') then
    instrD   <= x"00000000";
    pcplus4D <= x"00000000";
   elsif (enable = '1') then
    pcplus4D <= pcplus4F;
    instrD <= instrF;
   end if;
  end if;
 end process;
end Behavioral;

