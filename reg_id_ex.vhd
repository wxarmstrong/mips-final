library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reg_id_ex is
 port
 (
  clk, reset:      in  STD_LOGIC;
  id_regwrite, id_memtoreg, id_memwrite, id_alusrc, id_regdst, id_immsrc: in  STD_LOGIC;
  id_aluctrl:          in  STD_LOGIC_VECTOR(2 downto 0);
  id_rs, id_rt, id_rd: in  STD_LOGIC_VECTOR(4 downto 0);
  id_rd1, id_rd2, id_signimm, id_unsignimm:      in  STD_LOGIC_VECTOR(31 downto 0);
  ex_regwrite, ex_memtoreg, ex_memwrite, ex_alusrc, ex_regdst, ex_immsrc: out STD_LOGIC;
  ex_aluctrl:          out STD_LOGIC_VECTOR(2 downto 0);
  ex_rs, ex_rt, ex_rd: out STD_LOGIC_VECTOR(4 downto 0);
  ex_rd1, ex_rd2, ex_signimm, ex_unsignimm:      out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of reg_id_ex is
begin
 process(clk, reset) begin
  if (reset = '1') then
      ex_rd1 <= (others => '0');
      ex_rd2 <= (others => '0');
      ex_signimm <= (others => '0');
      ex_unsignimm <= (others => '0');
      ex_rs <= (others => '0');
      ex_rt <= (others => '0');
      ex_rd <= (others => '0');
      ex_immsrc <= '0';
      ex_aluctrl <= (others => '0');
      ex_regwrite <= '0';
      ex_memtoreg <= '0';
      ex_memwrite <= '0';
      ex_alusrc <= '0';
      ex_regdst <= '0';
  elsif rising_edge(clk) then
      ex_rd1 <= id_rd1;
      ex_rd2 <= id_rd2;
      ex_signimm <= id_signimm;
      ex_unsignimm <= id_unsignimm;
      ex_rs <= id_rs;
      ex_rt <= id_rt;
      ex_rd <= id_rd;
      ex_immsrc <= id_immsrc;
      ex_aluctrl <= id_aluctrl;
      ex_regwrite <= id_regwrite;
      ex_memtoreg <= id_memtoreg;
      ex_memwrite <= id_memwrite;
      ex_alusrc <= id_alusrc;
      ex_regdst <= id_regdst;
  end if;
 end process;
end Behavioral;


