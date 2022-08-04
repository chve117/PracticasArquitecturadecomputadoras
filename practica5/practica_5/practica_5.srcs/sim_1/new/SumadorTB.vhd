----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2021 22:41:00
-- Design Name: 
-- Module Name: SumadorTB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SumadorTB is
--  Port ( );
end SumadorTB;

architecture Behavioral of SumadorTB is
component sumador8bits is
    Port ( a, b : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (7 downto 0);
           cout : out STD_LOGIC);
end component;

signal a, b : STD_LOGIC_VECTOR (7 downto 0);
signal sel :  STD_LOGIC;
signal  s : STD_LOGIC_VECTOR (7 downto 0);
signal  cout :  STD_LOGIC;

begin 
unidad1 : sumador8bits 
    Port map( 
    a => a, 
    b => b,
    sel => sel,
    s => s,
    cout => cout
    );

process
begin 
   a <= "00010111";
   b <= "01010111";
   sel <= '0';
   wait for 2ns;
   
   a <= "00011010";
   b <= "01011111";
   sel <= '0';
   wait for 2ns;
   
   a <= "00101001"; --41
   b <= "01100010"; --98
   sel <= '0';
   wait for 2ns;
   
    a <= "10111010"; --186
   b <= "00100100"; --35
   sel <= '0';
   wait for 2ns;
   a<="00111111"; -- 63
   b<="01100010"; --98
   wait for 15 ns;
   a<="00111100"; -- 60
   b<="00001111"; --15
   wait for 15 ns;
   a<="01111000"; -- 120
   b<="00110000"; --48
   wait for 15 ns;
   a<="00000001"; -- 1
   b<="00000100"; --4
   wait for 15 ns;
   a<="00001011"; -- 11
   b<="00001000"; --8
   wait;
 end process;
end Behavioral;
