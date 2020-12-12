--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; use IEEE.STD_LOGIC_1164.all;

-- Data Forwarding

entity dataforwarding is -- Data Fowarding unit
  port(regaddr:              in  STD_LOGIC_VECTOR(4 downto 0);
       writeRegM, writeRegW: in  STD_LOGIC_VECTOR(4 downto 0);
       regWriteM, regWriteW: in  STD_LOGIC;

       -- forward corresponds to a signal sent to a multiplexer to determine
       --  the source for the potential forwarded value (00 = no forwarding)

       forward:              out STD_LOGIC_VECTOR(1 downto 0));
end;

architecture behave of dataforwarding is
begin
  process(all) begin

  -- Data can be forwarded if:

  --- The register address to be used is the same as the most recent EX phase will be written to.
  --- (Use the data directly from the ALU in this case)
    if (regaddr /= "00000" and  regaddr = writeRegM and regWriteM = '1') then
      forward <= "10";

  --- The register address to be used is the same as the most recent MEM phase will be written to.
  --- (Use the data directly from the WB phase)
    elsif (regaddr /= "00000" and regaddr = writeRegW and regWriteW = '1') then
      forward <= "01";

  -- NO FORWARDING:
    else
      forward <= "00";

    end if;
  end process;
end;