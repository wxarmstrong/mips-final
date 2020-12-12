--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; use IEEE.STD_LOGIC_1164.all;

-- Control Forwarding

entity controlforwarding is
  port(regaddr:   in  STD_LOGIC_VECTOR(4 downto 0);
       writeRegM: in  STD_LOGIC_VECTOR(4 downto 0);
       regWriteM: in  STD_LOGIC;
       forward:   out STD_LOGIC);
end;

architecture behave of controlforwarding is
begin
  process(all) begin

  -- Control forwarding occurs if:
  --- The register address to be used is the same as the most recent EX phase will be written to.
  --- This allows for the value required for a BEQ/BNE comparison to be taken directly from the
  --- ALU result without having to be read back from the register.

    if(regaddr /= "00000" and  regaddr = writeRegM and regWriteM = '1') then
      forward <= '1';
    else
      forward <= '0';
    end if;

  end process;
end;

