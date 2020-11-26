library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reg_if_id is
 port
 (
  clk, reset:      in  STD_LOGIC;
  pcplus4F, instF: in  STD_LOGIC_VECTOR(31 downto 0);
  pcplus4D, instD: out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of reg_if_id is
begin
 process(clk, reset) begin
  if (reset = '1') then
   instD    <= x"00000000";
   pcplus4D <= x"00000000";
  elsif rising_edge(clk) then
   instD <= instF;
   pcplus4D <= pcplus4F;
  end if;
 end process;
end Behavioral;

