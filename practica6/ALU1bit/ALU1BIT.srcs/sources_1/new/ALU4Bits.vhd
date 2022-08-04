library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU4Bits is
    Port ( ALUOP : in STD_LOGIC_VECTOR (3 downto 0);
           a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0);
           OV : out STD_LOGIC;
           N : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end ALU4Bits;

architecture Behavioral of ALU4Bits is

component ALU1Bit is
    Port ( selA : in STD_LOGIC;
           selB : in STD_LOGIC;
           op : in STD_LOGIC_VECTOR (1 downto 0);
           a : in STD_LOGIC;
           b : in STD_LOGIC;
           Cin : in STD_LOGIC;
           res : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;

signal Ci_s: STD_LOGIC_VECTOR (4 downto 0);
signal auxS: STD_LOGIC_VECTOR (3 downto 0);
begin
    Ci_s(0)<=ALUOP(2); --selB
    comp: for i in 0 to 3 generate
        ALU: ALU1Bit 
        port map(
            selA => ALUOP(3),
            selB => ALUOP(2),
            op(1) => ALUOP(1),
            op(0) => ALUOP(0),
            a => a(i),
            b => b(i),
            Cin => Ci_s(i),
            res => auxS(i),
            Cout => Ci_s(i+1)
            );
        S(i)<= auxS(i);
    end generate;
    
    --Banderas
    OV<=Ci_s(4)xor Ci_s(3); --Overflow
    N<=auxS(3); --Signo
    Z<=not(auxS(3) or auxS(2) or auxS(1) or auxS(0)); --Zero
    C<=Ci_s(4); --carry
    
end Behavioral;