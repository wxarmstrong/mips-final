--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD_UNSIGNED.all;

-- Adder

entity adder is
 port(
  a, b: in  STD_LOGIC_VECTOR(31 downto 0);
  c:    out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of adder is
begin
  c <= a+b;
end;