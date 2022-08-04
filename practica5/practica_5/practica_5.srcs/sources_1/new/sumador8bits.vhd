
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sumador8bits is
    Port ( a, b : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (7 downto 0);
           cout : out STD_LOGIC);
end sumador8bits;

architecture Behavioral of sumador8bits is
signal eb : std_logic_vector(7 downto 0);
signal c : std_logic_vector(8 downto 0);

begin
   c(0) <= sel;
   ciclo : for i in 0 to 7 generate
      eb(i) <= b(i) xor c(0);
      s(i) <= a(i) xor eb(i) xor c(i);
      c(i+1) <= (a(i) and eb(i)) or (a(i) and c(i)) or (eb(i) and c(i));
end generate;
cout <= c(8);
end Behavioral;
