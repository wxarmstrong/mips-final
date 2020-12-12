--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD_UNSIGNED.all;

-- Register File betwee ID/EX phases

entity reg_id_ex is
  port(clk, reset:               in  STD_LOGIC;
       flush:                    in  STD_LOGIC;
       id_regwrite, id_memtoreg: in  STD_LOGIC;
       id_memwrite, id_alusrc:   in  STD_LOGIC;
       id_regdst, id_immsrc:     in  STD_LOGIC;
       id_alucontrol:            in  STD_LOGIC_VECTOR(2 downto 0);
       id_rd1, id_rd2:           in  STD_LOGIC_VECTOR(31 downto 0);
       id_signimm, id_unsignimm: in  STD_LOGIC_VECTOR(31 downto 0);
       id_rs, id_rt, id_rd:      in  STD_LOGIC_VECTOR(4  downto 0);
       id_shift:                 in  STD_LOGIC_VECTOR(4 downto 0);
       ex_regwrite, ex_memtoreg: out STD_LOGIC;
       ex_memwrite, ex_alusrc:   out STD_LOGIC;
       ex_regdst, ex_immsrc:     out STD_LOGIC;
       ex_alucontrol:            out STD_LOGIC_VECTOR(2 downto 0);
       ex_rd1, ex_rd2:           out STD_LOGIC_VECTOR(31 downto 0);
       ex_signimm, ex_unsignimm: out STD_LOGIC_VECTOR(31 downto 0);
       ex_rs, ex_rt, ex_rd:      out STD_LOGIC_VECTOR(4  downto 0);
       ex_shift:                 out STD_LOGIC_VECTOR(4 downto 0));
end;

architecture behave of reg_id_ex is
begin
  process(clk)
  begin
    -- Clear on reset
    if (reset = '1') then
      ex_rd1 <= (others => '0');
      ex_rd2 <= (others => '0');
      ex_signimm <= (others => '0');
      ex_unsignimm <= (others => '0');
      ex_rs <= (others => '0');
      ex_rt <= (others => '0');
      ex_rd <= (others => '0');
      ex_shift <= (others => '0');
      ex_immsrc <= '0';
      ex_alucontrol <= (others => '0');
      ex_regwrite <= '0';
      ex_memtoreg <= '0';
      ex_memwrite <= '0';
      ex_alusrc <= '0';
      ex_regdst <= '0';
    elsif rising_edge(clk) then
      -- If branch is followed, clear existing values
      if (flush = '1') then
        ex_rd1 <= (others => '0');
        ex_rd2 <= (others => '0');
        ex_signimm <= (others => '0');
        ex_unsignimm <= (others => '0');
        ex_rs <= (others => '0');
        ex_rt <= (others => '0');
        ex_rd <= (others => '0');
        ex_shift <= (others => '0');
        ex_immsrc <= '0';
        ex_alucontrol <= (others => '0');
        ex_regwrite <= '0';
        ex_memtoreg <= '0';
        ex_memwrite <= '0';
        ex_alusrc <= '0';
        ex_regdst <= '0';
      else 
        ex_rd1 <= id_rd1;
        ex_rd2 <= id_rd2;
        ex_signimm <= id_signimm;
        ex_unsignimm <= id_unsignimm;
        ex_rs <= id_rs;
        ex_rt <= id_rt;
        ex_rd <= id_rd;
        ex_shift <= id_shift;
        ex_immsrc <= id_immsrc;
        ex_alucontrol <= id_alucontrol;
        ex_regwrite <= id_regwrite;
        ex_memtoreg <= id_memtoreg;
        ex_memwrite <= id_memwrite;
        ex_alusrc <= id_alusrc;
        ex_regdst <= id_regdst;
      end if;
    end if;
  end process;
end;
