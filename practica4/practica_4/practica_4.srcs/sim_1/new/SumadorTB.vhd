library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SumadorTB is
--  Port ( );
end SumadorTB;

architecture Behavioral of SumadorTB is
component Sumador4bits is
    Port ( a, b : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (3 downto 0);
           sou : out STD_LOGIC);
end component;


    signal  a, b :  STD_LOGIC_VECTOR (3 downto 0);
    signal       sel :  STD_LOGIC;
    signal       s :  STD_LOGIC_VECTOR (3 downto 0);
    signal       sou :  STD_LOGIC;    
begin
  unidad1 : Sumador4bits
  Port map( 
     a =>a,
     b => b,
       sel => sel,
       s => s,
       sou => sou
     );

process
begin
 a <= "0110";
 b <= "0111";
 sel <= '0';
 wait for 20 ns;
 
 a <= "0110";
 b <= "1001";
 sel <= '0';
 wait for 20 ns;
 
 a <= "0100";
 b <= "1001";
 sel <= '0';
 wait for 20 ns;
 
 a <= "1111";
 b <= "1001";
 sel <= '1';
 wait for 20 ns;
 
 a <= "0011";
 b <= "1010";
 sel <= '0';
 wait for 20 ns;
 
 a <= "1100";
 b <= "0101";
 sel <= '1';
 wait for 20 ns;
 
 a <= "1110";
 b <= "1000";
 sel <= '1';
 wait for 20 ns;
 
 a <= "1010";
 b <= "0110";
 sel <= '1';
 wait for 20 ns;
 
 a <= "1001";
 b <= "0100";
 sel <= '1';
 
 wait;
end process;

end Behavioral;
