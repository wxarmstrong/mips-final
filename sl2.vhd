library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD_UNSIGNED.all;

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