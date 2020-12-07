library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hazardunit is 
	port (
		rse, rte, rsd, rtd: in STD_LOGIC_VECTOR(4 downto 0);
		regWriteM, regWriteW, regWriteE: in STD_LOGIC;
		writeRegM, writeRegW, writeRegE: in STD_LOGIC_VECTOR(4 downto 0);
		memToRegE, memToRegM: in STD_LOGIC;
		branchD: in STD_LOGIC;
		forwardAE, forwardBE: out STD_LOGIC_VECTOR (1 downto 0);
		forwardAD, forwardBD: out STD_LOGIC;
		stallF, stallD, flushE: out STD_LOGIC);
end;

architecture struct of hazardunit is
	component datafowarding
		port(
			regaddr: in STD_LOGIC_VECTOR(4 downto 0);
			writeRegM, writeRegW: in STD_LOGIC_VECTOR(4 downto 0);
			regWriteM, regWriteW: in STD_LOGIC;
         		forward: out STD_LOGIC_VECTOR(1 downto 0));
  	end component;
	component hardwarestall
    		port(
			rsD, rtE, rtD: in STD_LOGIC_VECTOR(4 downto 0);
         		memToRegE: in STD_LOGIC;
         		stall: out STD_LOGIC);
  	end component;
  	component controlfowarding
    		port(
			regaddr: in STD_LOGIC_VECTOR(4 downto 0);
         		writeRegM: in STD_LOGIC_VECTOR(4 downto 0);
         		regWriteM: in STD_LOGIC;
         		forward: out STD_LOGIC);
  	end component;
  	component branchstall
    		port(
			rsD, rtD: in STD_LOGIC_VECTOR(4 downto 0);
          		branchD: in STD_LOGIC;
         		regwriteE: in STD_LOGIC;
			writeregE, writeregM: in STD_LOGIC_VECTOR(4 downto 0);
          		memToRegM: in STD_LOGIC;
          		stall: out STD_LOGIC);
  	end component;

	signal lwstall, brstall: STD_LOGIC;
	begin
  		forwardingAE: datafowarding port map (rsE, writeRegM, writeRegW, regWriteM, regWriteW, forwardAE);
  		forwardingBE: datafowarding port map (rtE, writeRegM, writeRegW, regWriteM, regWriteW, forwardBE);
  		forwardingAD: controlfowarding port map (rsD, writeRegM, regWriteM, forwardAD);
  		forwardingBD: controlfowarding port map (rtD, writeRegM, regWriteM, forwardBD);
  		hadwarestalling: hardwarestall port map (rsD, rtE, rtD, memToRegE, lwstall);
  		branchstalling: branchstall port map (rsD, rtD, branchD, regWriteE, writeRegE, writeRegM, memToRegM, brstall);
  		stallF <= lwstall or brstall;
  		stallD <= lwstall or brstall;
  		flushE <= lwstall or brstall;
                --forwardAE <= "00";
                --forwardBE <= "00";
                --forwardAD <= '0';
                --forwardBD <= '0';
end; 
