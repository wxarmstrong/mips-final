--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; use IEEE.STD_LOGIC_1164.all;

-- ALU decoder

entity aludec is
  port(funct:      in  STD_LOGIC_VECTOR(5 downto 0);
       aluop:      in  STD_LOGIC_VECTOR(2 downto 0);
       alucontrol: out STD_LOGIC_VECTOR(2 downto 0));
end;

architecture behave of aludec is
begin
  process(funct, aluop) begin
    case aluop is

      -- I-type instructions
      when "000" => alucontrol <= "010"; -- add
      when "001" => alucontrol <= "110"; -- sub
      when "010" => alucontrol <= "000"; -- and
      when "011" => alucontrol <= "001"; -- or
      when "100" => alucontrol <= "111"; -- slt
      when others => case funct is

                         -- R-type instructions
                         when "000000" => alucontrol <= "011"; -- sll
                         when "000010" => alucontrol <= "100"; -- srl
                         when "100000" => alucontrol <= "010"; -- add 
                         when "100010" => alucontrol <= "110"; -- sub
                         when "100100" => alucontrol <= "000"; -- and
                         when "100101" => alucontrol <= "001"; -- or
                         when "100110" => alucontrol <= "101"; -- xor
                         when "101010" => alucontrol <= "111"; -- slt
                         when others   => alucontrol <= "---"; -- invalid
                     end case;
    end case;
  end process;
end;
