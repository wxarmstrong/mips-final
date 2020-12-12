--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 

-- Sign extender

entity signext is
 port(
  a: in  STD_LOGIC_VECTOR(15 downto 0);
  b: out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of signext is
begin
  b <= x"FFFF" & a when (a >= x"8000") else x"0000" & a;
end;