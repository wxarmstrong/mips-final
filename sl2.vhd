--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 

-- Shift left by 2

entity sl2 is
 port(
  a: in  STD_LOGIC_VECTOR(31 downto 0);
  b: out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of sl2 is
begin
  b <= a(29 downto 0) & "00";
end;