--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD_UNSIGNED.all;
use ieee.numeric_std.all;

-- ALU

entity alu is 
  port(a, b:       in  STD_LOGIC_VECTOR(31 downto 0);
       alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
       shift:      in  STD_LOGIC_VECTOR(4 downto 0);
       result:     out STD_LOGIC_VECTOR(31 downto 0);
       zero:       out STD_LOGIC);
end;

architecture behave of alu is
signal result0: STD_LOGIC_VECTOR(31 downto 0);
begin
 process(a, b, alucontrol, shift) begin

  if (alucontrol = "000") then
   result0 <= a and b;
  elsif (alucontrol = "001") then 
   result0 <= a or b;
  elsif (alucontrol = "010") then
   result0 <= a + b;
  elsif (alucontrol = "011") then
   result0 <= shift_left(b, to_integer(shift) );
  elsif (alucontrol = "100") then
   result0 <= shift_right(b, to_integer(shift) );
  elsif (alucontrol = "110") then
   result0 <= a - b;
  elsif (alucontrol = "101") then
   result0 <= a xor b;
  elsif (alucontrol = "111") then
   if (a < b) then
    result0 <= x"00000001";
   else
    result0 <= x"00000000";
   end if;
  else
   result0 <= (others => 'X'); 
  end if;

  end process;
  
  result <= result0;
  zero <= '1' when result0 = X"00000000" else '0';
  
end;