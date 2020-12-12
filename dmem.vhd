--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; 
use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
use IEEE.NUMERIC_STD_UNSIGNED.all; 

entity dmem is -- data memory
  port(clk, we:  in STD_LOGIC;
       a, wd:    in STD_LOGIC_VECTOR(31 downto 0);
       rd:       out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of dmem is
begin
  process is
    type ramtype is array (255 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    variable mem: ramtype := (others=>(others=>'0'));
  begin
   loop
      if clk'event and clk = '0' then
          if (we = '1') then mem(to_integer( a(7 downto 0) )) := wd;
          end if;
      end if;
      rd <= mem(to_integer( a(7 downto 0) )); 
      wait on clk, a;
  end loop;

  end process;
end;