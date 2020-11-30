library IEEE; use IEEE.STD_LOGIC_1164.all;

entity hardwarestall is -- Hardware Stall unit
  port(rsD, rtE, rtD: in  STD_LOGIC_VECTOR(4 downto 0);
       memToRegE:     in  STD_LOGIC;
       stall:         out STD_LOGIC);
end;

architecture behave of hardwarestall is
begin
  process(rsD, rtE, rtD, memToRegE) begin
    if (memToRegE = '1') and ((rsD = rtE) or (rtD = rtE)) then
      stall <= '1';
    else
      stall <= '0';
    end if;
  end process;
end;

library IEEE; use IEEE.STD_LOGIC_1164.all;

entity branchstall is -- Hardware Stall unit
  port(rsD, rtD:             in  STD_LOGIC_VECTOR(4 downto 0);
       branchD:              in  STD_LOGIC;
       regwriteE:            in  STD_LOGIC;
       writeregE, writeregM: in  STD_LOGIC_VECTOR(4 downto 0);
       memToRegM:            in  STD_LOGIC;
       stall:                out STD_LOGIC);
end;