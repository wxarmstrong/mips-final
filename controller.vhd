library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller is Port (
	opcode: in STD_LOGIC_VECTOR(5 downto 0);
	regdst: out STD_LOGIC;
	jump: out STD_LOGIC;
	branch: out STD_LOGIC;
	memread: out STD_LOGIC;
	memtoreg: out STD_LOGIC;
	aluop: out STD_LOGIC_VECTOR (1 downto 0);
	memwrite: out STD_LOGIC;
	alusrc: out STD_LOGIC;
	regwrite: out STD_LOGIC
	);
end controller;

architecture Behavioral of controller is 
begin
	process(opcode)
	begin
		regwrite <= '0';
		case opcode is
			when "000000" => -- add, sub, and, or, slt, xor, sll, srl
				regdst <= '1';
				jump <= '0';
				branch <= '0';
				memread <= '0';
				memtoreg <= '0';
				aluop <= "10";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '1' after 10 ns;
			when "100011" => --load word
				regdst <= '0';
				jump <= '0';
				branch <= '0';
				memread <= '1';
				memtoreg <= '1';
				aluop <= "00";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1' after 10 ns;
			when "101011" => --save word
				regdst <= 'X';
				jump <= '0';
				branch <= '0';
				memread <= '0';
				memtoreg <= 'X';
				aluop <= "00";
				memwrite <= '1';
				alusrc <= '1';
				regwrite <= '0';
			when "000100" => -- branch equal
				regdst <= 'X';
				jump <= '0';
				branch <= '1' after 2 ns;
				memread <= '0';
				memtoreg <= 'X';
				aluop <= "01";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
			when "000010" => --jump
				regdst <= 'X';
				jump <= '1';
				branch <= '0';
				memread <= '0';
				memtoreg <= 'X';
				aluop <= "00";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
			when "001000" => --add immediate
				regdst <= '0';
				jump <= '0';
				branch <= '0';
				memread <= '0';
				memtoreg <= '0';
				aluop <= "00";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "001100" => --and immediate
				regdst <= '0';
				jump <= '0';
				branch <= '0';
				memread <= '0';
				memtoreg <= '0';
				aluop <= "11";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "001101" => --or immediate
				regdst <= '0';
				jump <= '0';
				branch <= '0';
				memread <= '0';
				memtoreg <= '0';
				aluop <= "11";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "001010" => --set on less than immediate
				regdst <= '0';
				jump <= '0';
				branch <= '0';
				memread <= '0';
				memtoreg <= '0';
				aluop <= "11";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when others => null;
				regdst <= '0';
				jump <= '0';
				branch <= '0';
				memread <= '0';
				memtoreg <= '0';
				aluop <= "00";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
		end case;
	end process;
end Behavioral;