--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;  

-- Instruction memory

entity imem is
 port
 (
  pc:   in  STD_LOGIC_VECTOR(31 downto 0);
  inst: out STD_LOGIC_VECTOR(31 downto 0)
 );
end;

architecture Behavioral of imem is
 type Instruction is array (0 to 15) of std_logic_vector(31 downto 0);
 constant rom_data: Instruction:=(

--addi $t0, $0, 10    
--addi $t1, $0,  5    
--andi $t2, $0, 4   
--sw $t1, 8($s0)      

--addi $t3, $t0, 15   
--sub $t4, $t3, $t0  
--ori $t5, $t2, 4   
--lw $t6, 8($s0)     

--add $t3, $t3, $t1   
--or $t5, $t5, $t2  
--xor $t3, $t4, $t2   
--slti $t7, $t6, 5  

--and $t7, $t5, $t3  
--slt $t8, $t3, $t4  
--sll $t8, $t0, 5     
--srl $t7, $t1, 5     

"00100000000010000000000000001010",
"00100000000010010000000000000101",
"00110000000010100000000000000100",
"10101110000010010000000000001000",

"00100001000010110000000000001111",
"00000001011010000110000000100010",
"00110101010011010000000000000100",
"10001110000011100000000000001000",

"00000001011010010101100000100000",
"00000001101010100110100000100101",
"00000001100010100101100000100110",
"00101001110011110000000000000101",

"00000001101010110111100000100100",
"00000001011011001100000000101010",
"00000000000010001100000101000000",
"00000000000010010111100101000010"
 );

begin
 process is
 begin
  loop
   -- Run blank instructions if PC goes past size of imem
   if (pc >= 16*4) then
    inst <= x"00000000";
   else
   -- Divide PC by 4 to get the correct instruction index #
    inst <= rom_data(to_integer(pc)/4);
   end if;
   wait on pc;
  end loop;
 end process;
end;