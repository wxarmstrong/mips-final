--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD_UNSIGNED.all;

-- Register File

entity RegisterFile is
  port(clk:           in  STD_LOGIC;
       we3:           in  STD_LOGIC;
       ra1, ra2, wa3: in  STD_LOGIC_VECTOR(4 downto 0);
       wd3:           in  STD_LOGIC_VECTOR(31 downto 0);
       rd1, rd2:      out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of RegisterFile is
  type ramtype is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
  -- Initialize registers at zero
  signal mem: ramtype := (others=>(others=>'0'));
begin

  process(clk, wa3, we3, wd3) begin
    -- Write back to register at falling edge (end) of WB phase
    if falling_edge(clk) then
       if we3 = '1' then mem(to_integer(wa3)) <= wd3;
       end if;
    end if;
  end process;

  process(ra1, ra2) begin
    -- Zero register
    if (to_integer(ra1) = 0) then rd1 <= X"00000000";
    else rd1 <= mem(to_integer(ra1));
    end if;
    if (to_integer(ra2) = 0) then rd2 <= X"00000000"; 
    else rd2 <= mem(to_integer(ra2));
    end if;
  end process;

end;