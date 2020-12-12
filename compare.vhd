--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Compare

entity compare is
  port (a, b: in STD_LOGIC_VECTOR(31 downto 0) ;
        eq: out STD_LOGIC);
end;

architecture behave of compare is
begin
  eq <= '1' when a = b else '0';
end;