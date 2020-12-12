--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity flopr is
 port(
  clk, reset, enable: in  STD_LOGIC;
  d:                  in  STD_LOGIC_VECTOR(31 downto 0);
  q:                  out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of flopr is

begin

  process(clk, reset) begin

    if (reset = '1') then  q <= (others => '0');
    elsif rising_edge(clk) then
      if (enable = '1') then
        q <= d;
      end if;
    end if;

  end process;

end;