--Register File
--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

Library ieee;
use ieee.numeric_std.all;  
use ieee.std_logic_1164.all;

entity RegisterFile is
Port(
        clk      : in std_logic;
	readReg1 : in std_logic_vector (5 downto 0);					--create a 6 bit read Register
	readReg2 : in std_logic_vector (5 downto 0);					--create a second 6 bit read register0
	writeReg : in std_logic_vector (5 downto 0);					--create a 6 bit write register
	writeData  : in std_logic_vector (31 downto 0);					--create a 32 bit write data register
	regWrite : in std_logic;										--create a 1 bit register Write
	readData1 : out std_logic_vector (31 downto 0);					--create a 32 bit read data register
	readData2 : out std_logic_vector (31 downto 0)					--create a second 32 bit read data register
	);
	
end RegisterFile;

architecture Behavioral of RegisterFile is

	type registerFileType is array(0 to 31) of						--create an array type of size 32 bits
		std_logic_vector(31 downto 0);

	signal regArray : registerFileType := (							--intitial and set the values of an array to represent the 32 registers
											x"00000000", x"11111111", x"22222222", x"33333333",
											x"44444444", x"55555555", x"66666666", x"77777777",
											x"88888888", x"99999999", x"aaaaaaaa", x"bbbbbbbb",
											x"cccccccc", x"dddddddd", x"eeeeeeee", x"ffffffff",
											x"00000000", x"11111111", x"22222222", x"33333333",
											x"44444444", x"55555555", x"66666666", x"77777777",
											x"88888888", x"99999999", x"aaaaaaaa", x"bbbbbbbb",
											x"cccccccc", x"dddddddd", x"eeeeeeee", x"ffffffff"
										);

begin

process(regWrite)
	begin
		if(regWrite = '1')then										--if the controller sends a signal through Register Write, then
			regArray(to_integer(unsigned(writeReg))) <= writeData;  --set the value in writeData to the array at position Write Register
		end if;
	end process;
	
	readData1 <= regArray(to_Integer(unsigned(readReg1)));			--set read data 1 to source
	readData2 <= regArray(to_Integer(unsigned(readReg2)));			--set read data 2 to target
	

end Behavioral;