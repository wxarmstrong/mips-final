--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; use IEEE.STD_LOGIC_1164.all;

entity maindec is
  port(op:                 in  STD_LOGIC_VECTOR(5 downto 0);
       memtoreg, memwrite: out STD_LOGIC;
       branch, alusrc:     out STD_LOGIC;
       regdst, regwrite:   out STD_LOGIC;
       jump:               out STD_LOGIC;
       aluop:              out STD_LOGIC_VECTOR(2 downto 0);
       zerosrc:            out STD_LOGIC;
       immsrc:             out STD_LOGIC);
end;

architecture behave of maindec is
  signal controls: STD_LOGIC_VECTOR(11 downto 0);
  signal aluop_hi: STD_LOGIC;
  signal aluop_md: STD_LOGIC;
  signal aluop_lo: STD_LOGIC;
begin
  process(op) begin
    case op is
      --Register arithmetic
      when "000000" => controls <= "110000011100"; -- RTYPE
      --Immediate arithmetic
      when "001000" => controls <= "101000000000"; -- ADDI
      when "001100" => controls <= "101000001001"; -- ANDI
      when "001101" => controls <= "101000001101"; -- ORI
      --Comparison
      when "001010" => controls <= "101000010000"; -- SLTI
      --Memory
      when "100011" => controls <= "101001000000"; -- LW
      when "101011" => controls <= "001010000000"; -- SW
      --Jump
      when "000010" => controls <= "000000100000"; -- J
      --Branches
      when "000100" => controls <= "000100000100"; -- BEQ
      when "000101" => controls <= "000100000110"; -- BNE

      when others   => controls <= "------------"; -- illegal op
    end case;
  end process;

  (regwrite, regdst, alusrc, branch, memwrite,
   memtoreg, jump, aluop_hi, aluop_md, aluop_lo, zerosrc, immsrc) <= controls;
   aluop <= aluop_hi & aluop_md & aluop_lo;
end;
