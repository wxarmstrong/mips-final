library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity compare is
  port (a, b: in STD_LOGIC_VECTOR(31 downto 0) ;
        eq: out STD_LOGIC);
end;

architecture behave of compare is
begin
  eq <= '1' when a = b else '0';
end;