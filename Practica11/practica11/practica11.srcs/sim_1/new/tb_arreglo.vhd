library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_arreglo is
--  Port ( );
end tb_arreglo;

architecture Behavioral of tb_arreglo is

    component Arreglo is
        Port ( DA : in STD_LOGIC_VECTOR (8 downto 0);
               LA : in STD_LOGIC;
               EA : in STD_LOGIC;
               clr : in STD_LOGIC;
               clk : in STD_LOGIC;
               QA : out STD_LOGIC_VECTOR (8 downto 0));
    end component;

signal LA, EA ,clr, clk: STD_LOGIC;
signal DA, QA: STD_LOGIC_VECTOR (8 downto 0);

constant CLK_period : time := 30 ns;

begin
    registro: Arreglo port map
     (     DA => DA,
           LA => LA,
           EA => EA,
           clr => clr,
           clk => clk,
           QA => QA
      );
      
    CLK_Process: process
    begin
        clk <= '0';
		wait for CLK_period/2;
		clk <= '1';
		wait for CLK_period/2;
    end process;
    
    Stim_Process: process
    begin 
        clr<='1';
        wait for 50 ns; 
        clr<='0';
        LA<='1';
        EA<='0';
        DA<="000101101";
        wait until rising_edge(clk);
        LA<='0';
        EA<='0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        EA<='1';
        wait until rising_edge(clk);
        EA<='0';
        wait until rising_edge(clk);
        clr<='1';
        wait;
    end process;

end Behavioral;