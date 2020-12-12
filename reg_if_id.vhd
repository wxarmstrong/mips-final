--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Register file between IF/ID phases

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
  -- Clear on reset
  if (reset = '1') then
   instrD   <= x"00000000";
   pcplus4D <= x"00000000";
  elsif rising_edge(clk) then
   -- If pcsrc is active, then a branch has been followed so flush existing values that were
   --  obtained from initially assuming that the branch would not be followed.
   if (enable = '1' and flush = '1') then
    instrD   <= x"00000000";
    pcplus4D <= x"00000000";
   -- If stalling is not active:
   elsif (enable = '1') then
    pcplus4D <= pcplus4F;
    instrD <= instrF;
   end if;
  end if;
 end process;
end Behavioral;