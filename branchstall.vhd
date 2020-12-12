--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; use IEEE.STD_LOGIC_1164.all;

entity branchstall is
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

    -- A branch stall occurs if:
    --- A branch operation is occuring.
    --- One of the following conflicts is present:
    --- * The most recent EX phase involves a write to one of the two registers to be compared for the branch operation
    --- * The most recent MEM phase includes a lw to one of the two registers to be compared for the branch operation

    if (branchD = '1' and regwriteE = '1' and (writeregE = rsD or writeregE = rtD)) or (branchD = '1' and memtoregM = '1' and (writeRegM = rsD or writeregM = rtD)) then
      stall <= '1';
    else
      stall <= '0';
    end if;

  end process;
end;