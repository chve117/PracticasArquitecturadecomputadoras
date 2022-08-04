library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memoryData is
    generic(
        p: integer := 11; -- p=log_2(m) = log_2(2048) = 11
        n: integer := 16 
    );
    Port (
        dir : in STD_LOGIC_VECTOR(p-1 downto 0);
        dataIn: in STD_LOGIC_VECTOR (n-1 downto 0);
        clk, wd : in STD_LOGIC;
        dataOut: out STD_LOGIC_VECTOR(n-1 downto 0));
end memoryData;

architecture Behavioral of memoryData is
type matrix is array (0 to (2**p)-1) of STD_LOGIC_VECTOR(n-1 downto 0);
signal memory :matrix;
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(WD='1') then
                memory(conv_integer(dir)) <= dataIn;
            end if;
        end if;
    end process;
    
    dataOut <=memory(conv_integer(dir));

end Behavioral;
