library IEEE; use IEEE.STD_LOGIC_1164.all;

entity controlforwarding is -- Control Hazard Fowarding unit
  port(regaddr:   in  STD_LOGIC_VECTOR(4 downto 0);
       writeRegM: in  STD_LOGIC_VECTOR(4 downto 0);
       regWriteM: in  STD_LOGIC;
       forward:   out STD_LOGIC);
end;

architecture behave of controlforwarding is
begin
  process(all) begin
    if(regaddr /= "00000" and  regaddr = writeRegM and regWriteM = '1') then
      forward <= '1';
    else
      forward <= '0';
    end if;
  end process;
end;

