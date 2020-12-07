library IEEE; use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
  port(op:                 in  STD_LOGIC_VECTOR(5 downto 0);
       memtoreg, memwrite: out STD_LOGIC;
       branch, alusrc:     out STD_LOGIC;
       regdst, regwrite:   out STD_LOGIC;
       jump:               out STD_LOGIC;
       aluop:              out STD_LOGIC_VECTOR(1 downto 0);
       zerosrc:            out STD_LOGIC;
       immsrc:             out STD_LOGIC);
end;

architecture behave of maindec is
  signal controls: STD_LOGIC_VECTOR(10 downto 0);
  signal aluop_hi: STD_LOGIC;
  signal aluop_lo: STD_LOGIC;
begin
  process(op) begin
    case op is
      --Register arithmetic
      when "000000" => controls <= "11000001000"; -- RTYPE
      --Immediate arithmetic
      when "001000" => controls <= "10100000001"; -- ADDI
      when "001010" => controls <= "10100001001"; -- SLTI/ANDI
      when "001101" => controls <= "10100001101"; -- ORI
      --Memory
      when "100011" => controls <= "10100100000"; -- LW
      when "101011" => controls <= "00101000000"; -- SW
      --Jump
      when "000010" => controls <= "00000010000"; -- J
      --Branches
      when "000100" => controls <= "00010000100"; -- BEQ
      when "000101" => controls <= "00010000110"; -- BNE

      when others   => controls <= "-----------"; -- illegal op
    end case;
  end process;

  (regwrite, regdst, alusrc, branch, memwrite,
   memtoreg, jump, aluop_hi, aluop_lo, zerosrc, immsrc) <= controls;
   aluop <= aluop_hi & aluop_lo;
end;
