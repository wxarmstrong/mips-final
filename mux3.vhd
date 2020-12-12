--CS 3650 Fall 2020 Final Project
--William Armstrong
--Michael Than
--Dominic Guo
--Alisar Barakat

library IEEE; 
use IEEE.STD_LOGIC_1164.all;

-- Three-way multiplexer

entity mux3 is
  generic(width: integer);
  port(a, b, c: in  STD_LOGIC_VECTOR(width-1 downto 0);
       s:       in  STD_LOGIC_VECTOR(1 downto 0);
       y:       out STD_LOGIC_VECTOR(width-1 downto 0));
end;

architecture behave of mux3 is
begin
	process (a, b, c, s)
	begin
		case s is
			when "00" => y <= a;
	      		when "01" => y <= b;
	      		when "10" => y <= c;
	      		when others => y <= (others => 'X');
	    	end case;
	end process;
end;
