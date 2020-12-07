library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity mux2 is
 generic(width: integer);
 port(
  a, b: in  STD_LOGIC_VECTOR(width-1 downto 0);
  c:    in  STD_LOGIC;
  d:    out STD_LOGIC_VECTOR(width-1 downto 0)
 );
end;

architecture Behavioral of mux2 is
begin
  d <= a when (c = '0') else b;
end;