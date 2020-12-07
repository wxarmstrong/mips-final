library IEEE; 
use IEEE.STD_LOGIC_1164.all; 

-- unsign extender
entity unsignext is
 port(
  a: in  STD_LOGIC_VECTOR(15 downto 0);
  b: out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of unsignext is
begin
  b <= x"0000" & a;
end;
