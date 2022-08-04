library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_contador is
--  Port ( );
end tb_contador;

architecture Behavioral of tb_contador is
    component Contador is
        Port ( LB : in STD_LOGIC;
               EB : in STD_LOGIC;
               clk : in STD_LOGIC;
               clr : in STD_LOGIC;
               QB : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal LB, EB, clk, clr: STD_LOGIC;
    signal QB: STD_LOGIC_VECTOR (3 downto 0);
    
    constant CLK_period : time := 30 ns;

begin
    cont:Contador PORT MAP
         ( LB => LB,
           EB => EB,
           clk => CLK,
           clr => CLR,
           QB => QB
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
        LB<='0';
        EB<='0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        EB<='1';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        LB<='1';
        EB<='0';
        wait until rising_edge(clk);
        LB<='0';
        wait;
    end process;
    
end Behavioral;