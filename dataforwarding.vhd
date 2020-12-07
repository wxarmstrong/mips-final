library IEEE; use IEEE.STD_LOGIC_1164.all;

entity dataforwarding is -- Data Fowarding unit
  port(regaddr:              in  STD_LOGIC_VECTOR(4 downto 0);
       writeRegM, writeRegW: in  STD_LOGIC_VECTOR(4 downto 0);
       regWriteM, regWriteW: in  STD_LOGIC;
       forward:              out STD_LOGIC_VECTOR(1 downto 0));
end;

architecture behave of dataforwarding is
begin
  process(all) begin
    if(regaddr /= "00000" and  regaddr = writeRegM and regWriteM = '1') then
      forward <= "10";
    elsif(regaddr /= "00000" and regaddr = writeRegW and regWriteW = '1') then
      forward <= "01";
    else
      forward <= "00";
    end if;
  end process;
end;