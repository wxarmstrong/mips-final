--Data Memory
--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

Library ieee;
use ieee.numeric_std.all;  
use ieee.std_logic_1164.all;

entity dmem is
Port(
	--create address, writeData, memRead, memWrite inputs, and readData output
	address: in std_logic_Vector(31 downto 0);
	writeData: in std_logic_Vector(31 downto 0);
	memRead:in std_logic;
	memWrite:in std_logic;
	readData: out std_logic_Vector(31 downto 0));
end dmem;

architecture Behavioral of dmem is

	--create a type ram that is 16 x 32
	type ram is array(0 to 15) of std_logic_vector(31 downto 0); --16x32
	
	--initialize dataMem of type ram
	signal dataMem : ram := ( x"00000000",						--starts at 0x10010000
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000",
							  x"00000000"
							);
							
begin
	process(memWrite, memRead)
	begin
		--when memWrite switches from 0 to 1, write the info
		if(memWrite = '1') then
			--26850092 is 0x10010000, divide by 4 because each place is a word; so we can access an element at a time
			dataMem((to_integer(unsigned(address)) - 268500992)/4) <= writeData;
		end if;
		
		--when memRead switches from 0 to 1, read the information in dataMem at position address
		if(memRead = '1') then
			--26850092 is 0x10010000, divide by 4 because each place is a word; so we can read an element at a time
			readData <= dataMem((to_integer(unsigned(address)) - 268500992)/4);
		end if;
	end process;

end Behavioral;