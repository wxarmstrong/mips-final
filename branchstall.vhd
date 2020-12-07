library IEEE; use IEEE.STD_LOGIC_1164.all;

entity branchstall is -- Hardware Stall unit
  port(rsD, rtD:             in  STD_LOGIC_VECTOR(4 downto 0);
       branchD:              in  STD_LOGIC;
       regwriteE:            in  STD_LOGIC;
       writeregE, writeregM: in  STD_LOGIC_VECTOR(4 downto 0);
       memToRegM:            in  STD_LOGIC;
       stall:                out STD_LOGIC);
end;

architecture behave of branchstall is
begin
  process(rsD, rtD, branchD, regwriteE, writeregE, writeregM, memToRegM) begin
    if (branchD = '1' and regwriteE = '1' and (writeregE = rsD or writeregE = rtD)) or (branchD = '1' and memtoregM = '1' and (writeRegM = rsD or writeregM = rtD)) then
      stall <= '1';
    else
      stall <= '0';
    end if;
  end process;
end;